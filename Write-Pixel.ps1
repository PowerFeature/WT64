
Function Write-Pixel
{
    param(
            [String] [parameter(mandatory=$true, Valuefrompipeline = $true)] $Path,
            [Switch] $ToASCII
    )
    Begin
    {
        [void] [System.Reflection.Assembly]::LoadWithPartialName('System.Drawing.Common')
        
        # Console Colors and their Hexadecimal values
        $Colors = @{
            'FF000000' =   'Black'         
            'FF000080' =   'DarkBlue'      
            'FF008000' =   'DarkGreen'     
            'FF008080' =   'DarkCyan'      
            'FF800000' =   'DarkRed'       
            'FF800080' =   'DarkMagenta'   
            'FF808000' =   'DarkYellow'    
            'FFC0C0C0' =   'Gray'          
            'FF808080' =   'DarkGray'      
            'FF0000FF' =   'Blue'          
            'FF00FF00' =   'Green'         
            'FF00FFFF' =   'Cyan'          
            'FFFF0000' =   'Red'           
            'FFFF00FF' =   'Magenta'       
            'FFFFFF00' =   'Yellow'         
            'FFFFFFFF' =   'White'                 
        }
        
        # Algorithm to calculate closest Console color (Only 16) to a color of Pixel
        Function Get-ClosestConsoleColor($PixelColor)
        {
            ($(foreach ($item in $Colors.Keys) {
                [pscustomobject]@{
                    'Color' = $Item
                    'Diff'  = [math]::abs([convert]::ToInt32($Item,16) - [convert]::ToInt32($PixelColor,16))
                } 
            }) | Sort-Object Diff)[0].color
        }
    }
    Process
    {
        Foreach($item in $Path)
        {
            #Convert Image to BitMap            
            $BitMap = [System.Drawing.Bitmap]::FromFile((Get-Item $Item).fullname)

            Foreach($y in (1..($BitMap.Height-1)))
            {
                Foreach($x in (1..($BitMap.Width-1)))
                {
                    $Pixel = $BitMap.GetPixel($X,$Y)        
                    $BackGround = $Colors.Item((Get-ClosestConsoleColor $Pixel.name))
                    

                    If($ToASCII) # Condition to check ToASCII switch
                    {
                        Write-Host "$([Char](Get-Random -Maximum 126 -Minimum 33))" -NoNewline -ForegroundColor $BackGround
                    }
                    else
                    {
                        Write-Host " " -NoNewline -BackgroundColor $BackGround
                    }
                }
                Write-Host '' # Blank write-host to Start the next row
            }
        }        
    
    }
    end
    {
    
    }

}