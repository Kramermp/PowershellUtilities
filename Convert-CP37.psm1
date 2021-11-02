<#
    .SYNOPISIS
        Converts between Code Page 37 (IBM EBCDIC US/Canada) and ASCII
#>

function Convert-CP37toASCII {
    param(
        [String(Mandatory=$true)] $file,
        [String(Mandatory=$true)] $outFile
    )
    if(Test-Path($outFile)) {
        Write-Error "Outfile Already Exists"
        return
    }
    $fileStream = [System.IO.File]::Open($file, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
    $bufferedStream = [System.IO.BufferedStream]::new($fileStream)
    $streamReader = [System.IO.StreamReader]::new($bufferedStream)

    New-Item $outFile
    $fileOutStream = $fileStream = [System.IO.File]::Open($outFile, [System.IO.FileMode]::Open, [System.IO.FileAccess]::ReadWrite, [System.IO.FileShare]::ReadWrite)
    $bufferedOutStream = [System.IO.BufferedStream]::new($fileOutStream)
    $streamOutWriter= [System.IO.StreamWriter]::new($bufferedOutStream)

    $CP37 = [System.Text.Encoding]::GetEncoding(37)
    $ascii = [System.Text.Encoding]::GetEncoding("ASCII")

    #Read Contents into Buffer
    $line = $streamReader.ReadLine()
    while($line -ne $null) {
        $bytes = $ascii.GetBytes($line)
        $streamOutWriter.Write($ascii.GetString($CP37.GetBytes($line)))

        #Refresh Buffer
        $line = $streamReader.ReadLine()
    }

    #Close Things Down
    $streamOutWriter.Flush()
    $streamOutWriter.Close()
    $fileStream.Close()
    $fileOutStream.Close()
    $bufferedStream.Close()
    $bufferedOutStream.Close()
}

function Convert-ASCIItoCP37 {
    param(
        [String(Mandatory=$true)] $file,
        [String(Mandatory=$true)] $outFile
    )
    if(Test-Path($outFile)) {
        Write-Error "Outfile Already Exists"
        return
    }

    $fileStream = [System.IO.File]::Open($file, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
    $bufferedStream = [System.IO.BufferedStream]::new($fileStream)
    $streamReader = [System.IO.StreamReader]::new($bufferedStream)


    New-Item $outFile
    $fileOutStream = $fileStream = [System.IO.File]::Open($outFile, [System.IO.FileMode]::Open, [System.IO.FileAccess]::ReadWrite, [System.IO.FileShare]::ReadWrite)
    $bufferedOutStream = [System.IO.BufferedStream]::new($fileOutStream)
    $streamOutWriter= [System.IO.StreamWriter]::new($bufferedOutStream)

    $CP37 = [System.Text.Encoding]::GetEncoding(37)
    $ascii = [System.Text.Encoding]::GetEncoding("ASCII")

    #Read Things into Buffer
    $line = $streamReader.ReadLine()
    while($line -ne $null) {
        $bytes = $ascii.GetBytes($line)
        $streamOutWriter.Write($CP37.GetString($ascii.GetBytes($line)))

        #Refresh Buffer
        $line = $streamReader.ReadLine()
    }

    #Close Things Down
    $streamOutWriter.Flush()
    $streamOutWriter.Close()
    $fileStream.Close()
    $fileOutStream.Close()
    $bufferedStream.Close()
    $bufferedOutStream.Close()
}




