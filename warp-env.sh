# Environment for building/running this Dynamatic (warp-next). Source it: . ~/dynamatic-next/warp-env.sh
# Build: ./build.sh --release --use-prebuilt-llvm --disable-build-opt --enable-cbc --threads 6
#   (no clang/lld on the host -> gcc; Python >= 3.12 from uv; Gurobi's own python3.11 must not come first)
export GUROBI_HOME=/opt/gurobi1202/linux64
export PATH=/home/user/.local/share/uv/python/cpython-3.12-linux-x86_64-gnu/bin:$PATH:$GUROBI_HOME/bin
export LD_LIBRARY_PATH=$GUROBI_HOME/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
