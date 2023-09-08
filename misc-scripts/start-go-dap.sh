#!/bin/sh

while true; do pkill dlv; dlv dap -l 0.0.0.0:43000 --only-same-user=false --log=true --log-output=debugger,dap,rpc; sleep 1; done
