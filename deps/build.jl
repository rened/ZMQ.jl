using BinDeps

@BinDeps.setup

zmq = library_dependency("zmq", aliases = ["libzmq"])

provides(Sources,URI("http://download.zeromq.org/zeromq-3.2.4.tar.gz"),zmq)
provides(BuildProcess,Autotools(libtarget = "src/.libs/libzmq."*BinDeps.shlib_ext),zmq)
provides(Nix, zeromq3, zmq)

@windows_only begin
    provides(Binaries, {URI("http://s3.amazonaws.com/julialang/bin/winnt/extras/libzmq-3.3-x$WORD_SIZE.zip") => zmq}, os = :Windows )
end

@osx_only begin
    if Pkg.installed("Homebrew") === nothing
        error("Homebrew package not installed, please run Pkg.add(\"Homebrew\")")  end
    using Homebrew
    provides( Homebrew.HB, "zeromq32", zmq, os = :Darwin )
end

@BinDeps.install [:zmq => :zmq]
