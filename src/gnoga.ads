------------------------------------------------------------------------------
--                                                                          --
--                   GNOGA - The GNU Omnificent GUI for Ada                 --
--                                                                          --
--                                G N O G A                                 --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--                                                                          --
--                     Copyright (C) 2014 David Botton                      --
--                                                                          --
--  This library is free software;  you can redistribute it and/or modify   --
--  it under terms of the  GNU General Public License  as published by the  --
--  Free Software  Foundation;  either version 3,  or (at your  option) any --
--  later version. This library is distributed in the hope that it will be  --
--  useful, but WITHOUT ANY WARRANTY;  without even the implied warranty of --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                    --
--                                                                          --
--  As a special exception under Section 7 of GPL version 3, you are        --
--  granted additional permissions described in the GCC Runtime Library     --
--  Exception, version 3.1, as published by the Free Software Foundation.   --
--                                                                          --
--  You should have received a copy of the GNU General Public License and   --
--  a copy of the GCC Runtime Library Exception along with this program;    --
--  see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see   --
--  <http://www.gnu.org/licenses/>.                                         --
--                                                                          --
--  As a special exception, if other files instantiate generics from this   --
--  unit, or you link this unit with other files to produce an executable,  --
--  this  unit  does not  by itself cause  the resulting executable to be   --
--  covered by the GNU General Public License. This exception does not      --
--  however invalidate any other reasons why the executable file  might be  --
--  covered by the  GNU Public License.                                     --
--                                                                          --
-- GNOGA is intended to provide a cross platform environment for the        --
-- development of user interfaces using HTML5 technologies for rendering.   --
-- A GNOGA application is capable of being run over the internet or on      --
-- local machines using specialized browsers presenting to the user as any  --
-- native applicaiton would. GNOGA is designed with security features from  --
-- the start allow for fine grain profiles for user access.                 --
--                                                                          --
-- For more information please go to http://www.gnoga.com                   --
------------------------------------------------------------------------------                                                                          --

package Gnoga is
   version      : constant String := "0.0";
   version_high : constant        := 0;
   version_low  : constant        := 0;

   function Escape_Quotes (S : String) return String;
   --  Escape quotes for Java Script.

   function Left_Trim (S : String) return String;
   --  Remove leading spaces

   procedure Write_To_Console (Message : in String);
   --  Output message to console

   procedure Log (Message : in String);
   --  Output message to log (currently console)
end Gnoga;
