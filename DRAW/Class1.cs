using System;
using System.Collections.Generic;
using System.Linq;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Management.Automation;

namespace MyModule
{

    [Cmdlet(VerbsCommunications.Write, "TimestampedMessage")]
    public class WriteTimestampedMessageCommand : PSCmdlet
    {
        [Parameter(Position = 1)]
        public string Message { get; set; } = string.Empty;

        protected override void EndProcessing()
        {
            string timestamp = DateTime.Now.ToString("u");
            this.WriteObject($"[{timestamp}] - {this.Message}");
            base.EndProcessing();
        }
    }
    [Cmdlet(VerbsCommunications.Write, "DRAW")]
    public class DrawImageInConsoleCommand : PSCmdlet
    {
        [Parameter(Position = 1)]
        public string file { get; set; } = string.Empty;

        protected override void EndProcessing()
        {
            SessionState ss = new SessionState();
            int width = 128;
            int height = 128;
            var filePath = GetUnresolvedProviderPathFromPSPath(file);
            Console.WriteLine($"filePath {GetUnresolvedProviderPathFromPSPath(file)}");
            colorCompare cc = new colorCompare(); 

            using (FileStream pngStream = new FileStream(filePath, FileMode.Open, FileAccess.Read))
            using (var image = new Bitmap(pngStream))
            {
                var resized = new Bitmap(width, height);
                using (var graphics = Graphics.FromImage(resized))
                {
                    graphics.CompositingQuality = CompositingQuality.HighSpeed;
                    graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
                    graphics.CompositingMode = CompositingMode.SourceCopy;
                    graphics.DrawImage(image, 0, 0, width, height);
                    for (var line = 0; line < width; line++)
                    {
                        for (var pixel = 0; pixel < height; pixel++)
                        {
                            Console.BackgroundColor = ConsoleColor.Blue;
                            Console.BackgroundColor = cc.closestColor1(image.GetPixel(line,pixel));
                            Console.Write("*");
                        };
                        Console.Write("NL\n\r");
                    };
                }
            }



            base.EndProcessing();
        }

    }
    public class colorCompare
    {
        Color[] clist;
        List<Color> targets;
        // closed match for hues only:
        public Color closestColor1(Color target)
        {
            var hue1 = target.GetHue();
            var diffs = targets.Select(n => getHueDistance(n.GetHue(), hue1));
            var diffMin = diffs.Min(n => n);
            
            return targets[diffs.ToList().FindIndex(n => n == diffMin)];
        }

        // closed match in RGB space
        public Color closestColor2(Color target)
        {
            var colorDiffs = targets.Select(n => ColorDiff(n, target)).Min(n => n);
            return targets.Find(n => ColorDiff(n, target) == colorDiffs);
        }

        // weighed distance using hue, saturation and brightness
        /*int closestColor3(List<Color> colors, Color target)
        {
            float hue1 = target.GetHue();
            var num1 = ColorNum(target);
            var diffs = colors.Select(n => Math.Abs(ColorNum(n) - num1) +
                                           getHueDistance(n.GetHue(), hue1));
            var diffMin = diffs.Min(x => x);
            return diffs.ToList().FindIndex(n => n == diffMin);
        }*/
        // color brightness as perceived:
        float getBrightness(Color c)
        { return (c.R * 0.299f + c.G * 0.587f + c.B * 0.114f) / 256f; }

        // distance between two hues:
        float getHueDistance(float hue1, float hue2)
        {
            float d = Math.Abs(hue1 - hue2); return d > 180 ? 360 - d : d;
        }

        //  weighed only by saturation and brightness (from my trackbars)
        /*float ColorNum(Color c)
        {
            return c.GetSaturation() * factorSat +
                        getBrightness(c) * factorBri;
        }*/

        // distance in RGB space
        int ColorDiff(Color c1, Color c2)
        {
            return (int)Math.Sqrt((c1.R - c2.R) * (c1.R - c2.R)
                                   + (c1.G - c2.G) * (c1.G - c2.G)
                                   + (c1.B - c2.B) * (c1.B - c2.B));
        }
        public colorCompare()
        {
            // your array
            clist = new Color[13];
            clist[0] = Color.Blue;
            clist[1] = Color.BlueViolet;
            clist[2] = Color.Magenta;
            clist[3] = Color.Purple;
            clist[4] = Color.Red;
            clist[5] = Color.Tomato;
            clist[6] = Color.Orange;
            clist[7] = Color.Yellow;
            clist[8] = Color.YellowGreen;
            clist[9] = Color.Green;
            clist[10] = Color.SpringGreen;
            clist[11] = Color.Cyan;
            clist[12] = Color.Ivory;

            // and a list of color to test:
            targets = new List<Color>();
            targets.Add(Color.Pink);
            targets.Add(Color.OrangeRed);
            targets.Add(Color.LightPink);
            targets.Add(Color.DarkSalmon);
            targets.Add(Color.LightCoral);
            targets.Add(Color.DarkRed);
            targets.Add(Color.IndianRed);
            targets.Add(Color.LavenderBlush);
            targets.Add(Color.Lavender);
        }



    }



}