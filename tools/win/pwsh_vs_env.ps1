# Load VS env only once.
foreach ($vs_type in 'buildtools','community') {
    $vs_path="/program files (x86)/microsoft visual studio/2019/${vs_type}/vc/auxiliary/build"

    if (test-path $vs_path) {
        break
    }
    else {
        $vs_path=$null
    }
}

if ($vs_path -and -not $env:VSCMD_VER) {
    pushd $vs_path
    cmd /c 'vcvars64.bat & set' | where { $_ -match '=' } | %{
        $var,$val = $_.split('=')
        set-item -force "env:$var" -value $val
    }
    popd
}

