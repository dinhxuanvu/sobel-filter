-------------------------------------------------------
-- File:     Image_Process.vhd
-- Authors: Avery Francois, Drew Carlstedt
-- Entity:      Image_Process
-- Arch:     Mirror,Contrast,Filter
-- Created:  2/8/13
--
-- Description:  The following is an entity and
--               an arch. description image processing
--               algorithm
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity Image_Process is
   generic(
       max_row : integer := 512;
       max_col : integer := 512;
       win_size : integer := 3;
       percentagelow : integer := 3;
       percentagehigh : integer := 3);
end Image_Process;

architecture Mirror of Image_Process is

type timage is array( 1 to max_row, 1 to max_col ) of integer range 0 to 255;
file inFile : TEXT open READ_MODE is "boat.pgm";
file outFile : TEXT open WRITE_MODE is "boatOUT.pgm";

shared variable inimage, outimage : timage;
shared variable line1, line2, line3, line4 : line;
signal readdone, procdone : boolean := false;

begin
read1: process
   variable tempLine : line;
   variable pixel, row, col : integer;
   variable status : boolean;

begin
   --save header information
   readline( inFile, line1 );
   readline( inFile, line2 );
   readline( inFile, line3 );
   readline( inFile, line4 );

   row := 1;
   col := 1;
   
   --read rest of file
   while not endfile( inFile ) loop
       --get line
       readline( inFile, tempLine );
       status := true;
       while (status = true) loop     --checks for end of line
           --read pixels from line
           read( tempLine, pixel, status );
           if (status = true) then
               inimage(row,col) := pixel;
               if ( col = max_col ) then
                   col := 1;
                   row := row + 1;
               else
                   col := col + 1;
               end if;
           end if;
       end loop;
   end loop;

   readdone <= true;
   wait;
end process;

image_proc1: process
begin
   wait until readdone = true;
   
   --flip of image
   for row in 1 to max_row loop
       for col in 1 to max_col loop
           
           --horizontally
           outimage(row,max_col-col+1) := inimage(row, col);
   
           --vertically
           --outimage( max_row-row+1, col ) := inimage(row, col );

       end loop;
   end loop;

   procdone <= true;
   wait;
end process;

writing1: process
variable lineout : line;

begin

   wait until procdone = true;

--rewrite header lines
writeline( outFile, line1 );
writeline( outFile, line2 );
writeline( outFile, line3 );
writeline( outFile, line4 );

for row in 1 to max_row loop
   for col in 1 to max_col loop

       write( lineout, outimage(row, col) );
       write( lineout, ' ' );
   
   end loop;

   writeline( outfile, lineout );
end loop;

wait;
end process;

end Mirror;

architecture Stretching of Image_Process is
type timage is array( 1 to max_row, 1 to max_col ) of integer range 0 to 255;
file inFile : TEXT open READ_MODE is "boat.pgm";
file outFile : TEXT open WRITE_MODE is "boatOUT.pgm";

shared variable inimage, outimage : timage;
shared variable line1, line2, line3, line4 : line;
signal readdone, procdone : boolean := false;

begin
read1: process
 variable tempLine : line;
 variable pixel, row, col : integer;
 variable status : boolean;

begin
 --save header information
 readline( inFile, line1 );
 readline( inFile, line2 );
 readline( inFile, line3 );
 readline( inFile, line4 );

 row := 1;
 col := 1;

 --read rest of file
 while not endfile( inFile ) loop
    --get line
    readline( inFile, tempLine );
    status := true;
    while (status = true) loop     --checks for end of line
     --read pixels from line
     read( tempLine, pixel, status );
     if (status = true) then
       inimage(row,col) := pixel;
       if ( col = max_col ) then
         col := 1;
         row := row + 1;
       else
         col := col + 1;
       end if;
     end if;
    end loop;
 end loop;

 readdone <= true;
 wait;
end process;

image_proc2: process
type int_array is array (natural range<>) of integer range 0 to 255;
variable histogram : int_array(0 to max_row*max_col-1);
variable count : integer := 0;
variable swapped : std_logic := '1';
variable temp1 : integer;
variable glow : integer range 0 to 255; -- border gray low
variable ghigh : integer range 0 to 255; -- border gray high
constant num_to_0 : integer := (max_row * max_col * percentagelow)/100;
constant num_to_255 : integer := (max_row * max_col * percentagehigh)/100;

begin
 wait until readdone = true;

 -- make histogram
 for row in 1 to max_row loop
    for col in 1 to max_col loop
     histogram(count) := inimage(row,col);
     count := count + 1;
    end loop;
 end loop;

 -- sort histogram
 while swapped = '1' loop
    swapped := '0';
    for i in 1 to ((max_row*max_col)-1) loop
     if histogram(i-1) > histogram(i) then
       temp1 := histogram(i-1);
       histogram(i-1) := histogram(i);
       histogram(i) := temp1;
       swapped := '1';
     end if;
    end loop;
 end loop;

 -- assign the glow and ghigh grayscale boundaries
 glow := histogram(num_to_0);
 ghigh := histogram(((max_row*max_col)-1)-num_to_255);
       
 -- construct output image
 for row in 1 to max_row loop
    for col in 1 to max_col loop
     if inimage(row,col) <= glow then -- if it falls below glow, assigned to 0
       outimage(row,col) := 0;
     elsif inimage(row,col) > glow and inimage(row,col) < ghigh then -- inbetween gets adjusted
       outimage(row, col) := 255*(inimage(row,col)-glow)/(ghigh-glow);
     elsif inimage(row,col) >= ghigh then -- if it falls above ghigh, assigned to 255
       outimage(row,col) := ghigh;
     end if;
    end loop;
 end loop;

 procdone <= true;
 wait;
end process;


writing1: process
variable lineout : line;

begin

 wait until procdone = true;

--rewrite header lines
writeline( outFile, line1 );
writeline( outFile, line2 );
writeline( outFile, line3 );
writeline( outFile, line4 );

for row in 1 to max_row loop
 for col in 1 to max_col loop

    write( lineout, outimage(row, col) );
    write( lineout, ' ' );

 end loop;

 writeline( outfile, lineout );
end loop;

wait;
end process;

end architecture Stretching;

architecture Filtering of Image_Process is
type timage is array( 1 to max_row, 1 to max_col ) of integer range 0 to 255;
file inFile : TEXT open READ_MODE is "LenaNoise.pgm";
file outFile : TEXT open WRITE_MODE is "LenaOUT.pgm";

shared variable inimage, outimage : timage;
shared variable line1, line2, line3, line4 : line;
signal readdone, procdone : boolean := false;

begin
read1: process
 variable tempLine : line;
 variable pixel, row, col : integer;
 variable status : boolean;

begin
 --save header information
 readline( inFile, line1 );
 readline( inFile, line2 );
 readline( inFile, line3 );
 readline( inFile, line4 );

 row := 1;
 col := 1;

 --read rest of file
 while not endfile( inFile ) loop
    --get line
    readline( inFile, tempLine );
    status := true;
    while (status = true) loop     --checks for end of line
     --read pixels from line
     read( tempLine, pixel, status );
     if (status = true) then
       inimage(row,col) := pixel;
       if ( col = max_col ) then
         col := 1;
         row := row + 1;
       else
         col := col + 1;
       end if;
     end if;
    end loop;
 end loop;

 readdone <= true;
 wait;
end process;

image_proc3: process
variable count : integer := 0;
variable offset : integer := win_size/2;
type int_array is array (natural range<>) of integer;
variable histogram : int_array(0 to (win_size*win_size)-1);
variable new_pixel : integer := 0;
variable swapped : std_logic := '1';
variable temp1 : integer;

begin
 wait until readdone = true;

 for row in 1 to max_row-win_size loop -- go through all rows
    for col in 1 to max_col-win_size loop -- go through all cols
     count := 0;
     -- construct histogram
     for wrow in 0 to win_size-1 loop
       for wcol in 0 to win_size-1 loop
         histogram(count) := inimage(row+wrow, col+wcol);
         count := count + 1;
       end loop;
     end loop;
     
     -- sort histogram
     swapped := '1';
     while swapped = '1' loop
       swapped := '0';
       for i in 1 to ((win_size*win_size)-1) loop
         if histogram(i-1) > histogram(i) then
           temp1 := histogram(i-1);
           histogram(i-1) := histogram(i);
           histogram(i) := temp1;
           swapped := '1';
         end if;
       end loop;
     end loop;
     
     -- determine new pixel color
     new_pixel := histogram(((win_size*win_size)-1)/2);
     
     -- construct output image
     if row <= offset or col <= offset or -- keeps outer edges outside of window
       row >= max_row-offset or col >= max_col-offset then
       outimage(row,col) := inimage(row,col);
     end if;
     outimage(row+offset,col+offset) := new_pixel; -- overwrites noise
     
    end loop;
 end loop;

 procdone <= true;
 wait;
end process;

writing1: process
variable lineout : line;

begin

 wait until procdone = true;

--rewrite header lines
writeline( outFile, line1 );
writeline( outFile, line2 );
writeline( outFile, line3 );
writeline( outFile, line4 );

for row in 1 to max_row loop
 for col in 1 to max_col loop
    write( lineout, outimage(row, col) );
    write( lineout, ' ' );
 end loop;

 writeline( outfile, lineout );
end loop;

wait;
end process;
end architecture Filtering;

