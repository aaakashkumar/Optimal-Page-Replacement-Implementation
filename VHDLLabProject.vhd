-- VHDL Lab Project
-- Optimal Page Replacement

package mytypes_pkg is
     	type stringarray is array (13 downto 0) of integer;
	type framearray is array (2 downto 0) of integer;
end package mytypes_pkg;

library STD;
use STD.textio.all;                     -- basic I/O
use std.env.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_bit.all;
use ieee.numeric_std.all;
use work.mytypes_pkg.all;
use ieee.std_logic_textio.all;          -- I/O for logic types

entity opr is
	port
	(
	   referenceString: in stringarray := (1,4,2,3,1,0,3,2,1,0,3,2,1,0);-- A reference string of size 14
	   frame: inout framearray := (99,99,99)			-- 3 frames
	);
end opr;

architecture opr_arch of opr is
begin
    	process(referenceString,frame)
    	variable currentReferenceIndex: integer;
    	variable maximumDistanceIndex, maximumDistance, bigValue: integer := 0;
	variable pageFault, pageFaultCount: integer := 0;
    	variable pageExists: integer := 0;
    	variable distance: framearray := (99,99,99);
    	variable tempReferenceString: stringarray;
    	variable tempFrame: framearray;
	file file_handler     : text open write_mode is "opr.dat";
	variable row          : line;
	variable v_data_write : integer;

    begin
    	tempReferenceString(13 downto 0) := referenceString(13 downto 0);
    	tempFrame(2 downto 0) := frame(2 downto 0);

    	for currentReferenceIndex in 0 to 13 loop
		write(row, string'("Input: "));
		write(row, tempReferenceString(currentReferenceIndex));
		writeline(file_handler ,row);

		-- Initial conditions (memory is empty, initialized with -1)
        	if (tempFrame(0) = 99) then
        		tempFrame(0) := tempReferenceString(currentReferenceIndex);
			write(row, string'("Memory: "));
			writeline(file_handler, row);
			for x in 0 to 2 loop
				write(row, tempFrame(x));
				writeline(file_handler, row);
			end loop;
			write(row, string'("Page Fault: Yes"));
			writeline(file_handler, row);
			write(row, string'(" "));
			writeline(file_handler, row);

			pageFaultCount := pageFaultCount + 1;

        		frame(2 downto 0) <= tempFrame(2 downto 0);
        		next;

        	elsif (tempFrame(1) = 99) then
        		tempFrame(1) := tempReferenceString(currentReferenceIndex);
			write(row, string'("Memory: "));
			writeline(file_handler, row);
			for x in 0 to 2 loop
				write(row, tempFrame(x));
				writeline(file_handler, row);
			end loop;
			write(row, string'("Page Fault: Yes"));
			writeline(file_handler, row);
			write(row, string'(" "));
			writeline(file_handler, row);

			pageFaultCount := pageFaultCount + 1;

        		frame(2 downto 0) <= tempFrame(2 downto 0);
        		next;

        	elsif (tempFrame(2) = 99) then
        		tempFrame(2) := tempReferenceString(currentReferenceIndex);
			write(row, string'("Memory: "));
			writeline(file_handler, row);
			for x in 0 to 2 loop
				write(row, tempFrame(x));
				writeline(file_handler, row);
			end loop;
			write(row, string'("Page Fault: Yes"));
			writeline(file_handler, row);
			write(row, string'(" "));
			writeline(file_handler, row);

			pageFaultCount := pageFaultCount + 1;

        		frame(2 downto 0) <= tempFrame(2 downto 0);
        		next;

        	end if;

        	-- If required page is already in memory, page replacement is not required
        	pageExists := 0;
        	for I in 0 to 2 loop
        		if (tempFrame(I) = tempReferenceString(currentReferenceIndex)) then
        			pageExists := 1;
        		end if;
        	end loop;

        	if (pageExists = 1) then
        		frame(2 downto 0) <= tempFrame(2 downto 0);
			write(row, string'("Memory: "));
			writeline(file_handler, row);
			for x in 0 to 2 loop
				write(row, tempFrame(x));
				writeline(file_handler, row);
			end loop;
			write(row, string'("Page Fault: No"));
			writeline(file_handler, row);
			write(row, string'(" "));
			writeline(file_handler, row);

        		next;
        	end if;

        	-- In case of page fault, "replace a page that will not be used for the longest period of time"
        	distance := (0,0,0);
		bigValue := 99;

        	for I in 0 to 2 loop
			bigValue := bigValue + 1;
        		for J in currentReferenceIndex to 13 loop
    				distance(I) := distance(I) + 1;

    				pageExists := 0;
    				if (tempFrame(I) = tempReferenceString(J)) then
    					pageExists := 1;
    					exit;
    				end if ;

        		end loop;

        		if (pageExists = 0) then
        			distance(I) := bigValue;
        		end if;

        	end loop;

        	maximumDistance := 0;
		maximumDistanceIndex := 0;

        	for I in 0 to 2 loop
        		if (distance(I) > maximumDistance) then
        			maximumDistance := distance(I);
        			maximumDistanceIndex := I;
        		end if;
        	end loop;

        	tempFrame(maximumDistanceIndex) := tempReferenceString(currentReferenceIndex);
			write(row, string'("Memory: "));
			writeline(file_handler, row);
			for x in 0 to 2 loop
				write(row, tempFrame(x));
				writeline(file_handler, row);
			end loop;
			write(row, string'("Page Fault: Yes"));
			writeline(file_handler, row);
			write(row, string'(" "));
			writeline(file_handler, row);

			pageFaultCount := pageFaultCount + 1;

		

        	frame(2 downto 0) <= tempFrame(2 downto 0);
		end loop;

		write(row, string'(" "));
		writeline(file_handler, row);
		write(row, string'("Page Fault Rate = "));
		write(row, pageFaultCount);
		write(row, string'("/14"));
		writeline(file_handler, row);
	stop(0);
    end process;
end opr_arch;