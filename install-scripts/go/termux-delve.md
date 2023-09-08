# termux-delve

Temporary instructions to monkey patch `delve` to work on android
```
git clone https://github.com/go-delve/delve

# Patch these diffs
diff --git a/pkg/proc/bininfo.go b/pkg/proc/bininfo.go
index 4183196d..2fa15ae4 100644
--- a/pkg/proc/bininfo.go
+++ b/pkg/proc/bininfo.go
@@ -711,7 +711,7 @@ func loadBinaryInfo(bi *BinaryInfo, image *Image, path string, entryPoint uint64
        defer wg.Wait()

        switch bi.GOOS {
-       case "linux", "freebsd":
+       case "linux", "freebsd", "android":
                return loadBinaryInfoElf(bi, image, path, entryPoint, &wg)
        case "windows":
                return loadBinaryInfoPE(bi, image, path, entryPoint, &wg)
diff --git a/service/debugger/debugger.go b/service/debugger/debugger.go
index 291957a5..c16a21fd 100644
--- a/service/debugger/debugger.go
+++ b/service/debugger/debugger.go
@@ -2402,7 +2402,7 @@ func verifyBinaryFormat(exePath string) (string, error) {
        switch runtime.GOOS {
        case "darwin":
                exe, err = macho.NewFile(f)
-       case "linux", "freebsd":
+       case "linux", "freebsd", "android":
                exe, err = elf.NewFile(f)
        case "windows":
                exe, err = pe.NewFile(f)

# run build and install
make build
cp dlv /data/data/com.termux/files/usr/bin/dlv
```
