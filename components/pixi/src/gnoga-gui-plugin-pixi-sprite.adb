------------------------------------------------------------------------------
--                                                                          --
--                   GNOGA - The GNU Omnificent GUI for Ada                 --
--                                                                          --
--          G N O G A . G U I . P L U G I N . P I X I . S P R I T E         --
--                                                                          --
--                                 B o d y                                  --
--                                                                          --
--                     Copyright (C) 2017 Pascal Pignard                    --
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
-- For more information please go to http://www.gnoga.com                   --
------------------------------------------------------------------------------

with Ada.Numerics.Elementary_Functions;
with Gnoga.Server.Connection;

package body Gnoga.Gui.Plugin.Pixi.Sprite is

   ------------
   -- Create --
   ------------

   procedure Create
     (Sprite                                : in out Sprite_Type;
      Parent                                : in out Container_Type'Class;
      Texture                               : in     Texture_Type;
      Row, Column                           : in     Integer;
      Row_Velocity, Column_Velocity         : in     Velocity_Type     := 0.0;
      Row_Acceleration, Column_Acceleration : in     Acceleration_Type := 0.0)
   is
      Sprite_ID : constant String := Gnoga.Server.Connection.New_GID;
   begin
      Sprite.ID (Sprite_ID, Gnoga.Types.Gnoga_ID);
      Sprite.Connection_ID (Parent.Connection_ID);
      Gnoga.Server.Connection.Execute_Script
        (Sprite.Connection_ID,
         "gnoga['" &
         Sprite_ID &
         "'] = new PIXI.Sprite(gnoga['" &
         Texture.ID &
         "']);");
      Sprite.Locate (Row, Column);
      Sprite.Motion (Row_Velocity, Column_Velocity);
      Sprite.Acceleration (Row_Acceleration, Column_Acceleration);
      Sprite.Rotation_Velocity (0.0);
      Sprite.Rotation_Acceleration (0.0);
      Parent.Add_Child (Sprite);
   end Create;

   ------------
   -- Create --
   ------------

   procedure Create
     (Sprite                                : in out Sprite_Type;
      Parent                                : in out Container_Type'Class;
      Image_Path                            : in     String;
      Row, Column                           : in     Integer;
      Row_Velocity, Column_Velocity         : in     Velocity_Type     := 0.0;
      Row_Acceleration, Column_Acceleration : in     Acceleration_Type := 0.0)
   is
      Sprite_ID : constant String := Gnoga.Server.Connection.New_GID;
   begin
      Sprite.ID (Sprite_ID, Gnoga.Types.Gnoga_ID);
      Sprite.Connection_ID (Parent.Connection_ID);
      Gnoga.Server.Connection.Execute_Script
        (Sprite.Connection_ID,
         "gnoga['" &
         Sprite_ID &
         "'] = new PIXI.Sprite.fromImage('" &
         Image_Path &
         "');");
      Sprite.Locate (Row, Column);
      Sprite.Motion (Row_Velocity, Column_Velocity);
      Sprite.Acceleration (Row_Acceleration, Column_Acceleration);
      Sprite.Rotation_Velocity (0.0);
      Sprite.Rotation_Acceleration (0.0);
      Parent.Add_Child (Sprite);
   end Create;

   ------------
   -- Locate --
   ------------

   procedure Locate (Sprite : in out Sprite_Type; Row, Column : in Integer) is
   begin
      Sprite.Property ("x", Column);
      Sprite.Property ("y", Row);
   end Locate;

   --------------
   -- Position --
   --------------

   procedure Position (Sprite : in Sprite_Type; Row, Column : out Integer) is
   begin
      Row    := Sprite.Property ("y");
      Column := Sprite.Property ("x");
   end Position;

   ---------
   -- Row --
   ---------

   function Row (Sprite : in Sprite_Type) return Integer is
      V : constant Float := Sprite.Property ("y");
   begin
      return Integer (V);
   end Row;

   ------------
   -- Column --
   ------------

   function Column (Sprite : in Sprite_Type) return Integer is
      V : constant Float := Sprite.Property ("x");
   begin
      return Integer (V);
   end Column;

   -------------
   -- Pattern --
   -------------

   procedure Pattern (Sprite : in Sprite_Type; Image_Data : in String) is
   begin
      null; -- TODO
   end Pattern;

   -------------
   -- Pattern --
   -------------

   function Pattern (Sprite : in Sprite_Type) return String is
   begin
      return ""; -- TODO
   end Pattern;

   ------------
   -- Motion --
   ------------

   procedure Motion
     (Sprite                        : in out Sprite_Type;
      Row_Velocity, Column_Velocity : in     Velocity_Type)
   is
   begin
      Sprite.Property ("gnoga_vx", Column_Velocity / Frame_Rate);
      Sprite.Property ("gnoga_vy", Row_Velocity / Frame_Rate);
   end Motion;

   ------------------
   -- Row_Velocity --
   ------------------

   function Row_Velocity (Sprite : in Sprite_Type) return Velocity_Type is
   begin
      return Sprite.Property ("gnoga_vy") * Frame_Rate;
   end Row_Velocity;

   ---------------------
   -- Column_Velocity --
   ---------------------

   function Column_Velocity (Sprite : in Sprite_Type) return Velocity_Type is

   begin
      return Sprite.Property ("gnoga_vx") * Frame_Rate;
   end Column_Velocity;

   ------------------
   -- Acceleration --
   ------------------

   procedure Acceleration
     (Sprite                                : in out Sprite_Type;
      Row_Acceleration, Column_Acceleration : in     Acceleration_Type)
   is
   begin
      Sprite.Property
      ("gnoga_ax", Column_Acceleration / Frame_Rate / Frame_Rate);
      Sprite.Property ("gnoga_ay", Row_Acceleration / Frame_Rate / Frame_Rate);
   end Acceleration;

   ----------------------
   -- Row_Acceleration --
   ----------------------

   function Row_Acceleration
     (Sprite : in Sprite_Type) return Acceleration_Type
   is
   begin
      return Sprite.Property ("gnoga_ay") * (Frame_Rate * Frame_Rate);
   end Row_Acceleration;

   -------------------------
   -- Column_Acceleration --
   -------------------------

   function Column_Acceleration
     (Sprite : in Sprite_Type) return Acceleration_Type
   is

   begin
      return Sprite.Property ("gnoga_ax") * (Frame_Rate * Frame_Rate);
   end Column_Acceleration;

   -----------
   -- Alpha --
   -----------

   procedure Alpha
     (Sprite : in out Sprite_Type;
      Value  : in     Gnoga.Types.Alpha_Type)
   is
   begin
      Sprite.Property ("alpha", Float (Value));
   end Alpha;

   -----------
   -- Alpha --
   -----------

   function Alpha (Sprite : in Sprite_Type) return Gnoga.Types.Alpha_Type is
   begin
      return Gnoga.Types.Alpha_Type (Float'(Sprite.Property ("alpha")));
   end Alpha;

   ------------
   -- Anchor --
   ------------

   procedure Anchor
     (Sprite      : in out Sprite_Type;
      Row, Column : in     Gnoga.Types.Frational_Range_Type)
   is
   begin
      Gnoga.Server.Connection.Execute_Script
        (Sprite.Connection_ID,
         "gnoga['" &
         Sprite.ID &
         "'].anchor = {x:" &
         Column'Img &
         ",y:" &
         Row'Img &
         "};");
   end Anchor;

   ----------------
   -- Row_Anchor --
   ----------------

   function Row_Anchor
     (Sprite : in Sprite_Type) return Gnoga.Types.Frational_Range_Type
   is
   begin
      return Gnoga.Types.Frational_Range_Type
          (Float'(Sprite.Property ("anchor.y")));
   end Row_Anchor;

   -------------------
   -- Column_Anchor --
   -------------------

   function Column_Anchor
     (Sprite : in Sprite_Type) return Gnoga.Types.Frational_Range_Type
   is
   begin
      return Gnoga.Types.Frational_Range_Type
          (Float'(Sprite.Property ("anchor.x")));
   end Column_Anchor;

   ----------------
   -- Blend_Mode --
   ----------------

   procedure Blend_Mode
     (Sprite : in out Sprite_Type;
      Value  : in     Blend_Modes_Type)
   is
   begin
      Sprite.Property ("blendMode", Value'Img);
   end Blend_Mode;

   ----------------
   -- Blend_Mode --
   ----------------

   function Blend_Mode (Sprite : in Sprite_Type) return Blend_Modes_Type is
   begin
      return Blend_Modes_Type'Value (Sprite.Property ("blendMode"));
   end Blend_Mode;

   -----------
   -- Pivot --
   -----------

   procedure Pivot (Sprite : in out Sprite_Type; Row, Column : in Integer) is
   begin
      Gnoga.Server.Connection.Execute_Script
        (Sprite.Connection_ID,
         "gnoga['" &
         Sprite.ID &
         "'].pivot = {x:" &
         Column'Img &
         ",y:" &
         Row'Img &
         "};");
   end Pivot;

   ---------------
   -- Row_Pivot --
   ---------------

   function Row_Pivot (Sprite : in Sprite_Type) return Integer is
   begin
      return Sprite.Property ("pivot.x");
   end Row_Pivot;

   ------------------
   -- Column_Pivot --
   ------------------

   function Column_Pivot (Sprite : in Sprite_Type) return Integer is
   begin
      return Sprite.Property ("pivot.y");
   end Column_Pivot;

   --------------
   -- Rotation --
   --------------

   procedure Rotation (Sprite : in out Sprite_Type; Value : in Integer) is
   begin
      Sprite.Property ("rotation", Float (Value) * Ada.Numerics.Pi / 180.0);
   end Rotation;

   --------------
   -- Rotation --
   --------------

   function Rotation (Sprite : in Sprite_Type) return Integer is
   begin
      return Integer
          (Float'(Sprite.Property ("rotation")) * 180.0 / Ada.Numerics.Pi);
   end Rotation;

   -----------------------
   -- Rotation_Velocity --
   -----------------------

   procedure Rotation_Velocity
     (Sprite : in out Sprite_Type;
      Value  :        Velocity_Type)
   is
   begin
      Sprite.Property
      ("gnoga_vr", Value / Frame_Rate * Ada.Numerics.Pi / 180.0);
   end Rotation_Velocity;

   -----------------------
   -- Rotation_Velocity --
   -----------------------

   function Rotation_Velocity (Sprite : in Sprite_Type) return Velocity_Type is
   begin
      return Float'(Sprite.Property ("gnoga_vr")) *
        Frame_Rate *
        180.0 /
        Ada.Numerics.Pi;
   end Rotation_Velocity;

   -----------------------
   -- Rotation_Acceleration --
   -----------------------

   procedure Rotation_Acceleration
     (Sprite : in out Sprite_Type;
      Value  :        Acceleration_Type)
   is
   begin
      Sprite.Property
      ("gnoga_ar", Value / Frame_Rate / Frame_Rate * Ada.Numerics.Pi / 180.0);
   end Rotation_Acceleration;

   -----------------------
   -- Rotation_Acceleration --
   -----------------------

   function Rotation_Acceleration
     (Sprite : in Sprite_Type) return Acceleration_Type
   is
   begin
      return Float'(Sprite.Property ("gnoga_ar")) *
        Frame_Rate *
        Frame_Rate *
        180.0 /
        Ada.Numerics.Pi;
   end Rotation_Acceleration;

   -----------
   -- Width --
   -----------

   overriding procedure Width
     (Sprite : in out Sprite_Type;
      Value  : in     Integer)
   is
   begin
      Sprite.Property ("width", Value);
   end Width;

   -----------
   -- Width --
   -----------

   overriding function Width (Sprite : in Sprite_Type) return Integer is
   begin
      return Sprite.Property ("width");
   end Width;

   ------------
   -- Height --
   ------------

   overriding procedure Height
     (Sprite : in out Sprite_Type;
      Value  : in     Integer)
   is
   begin
      Sprite.Property ("height", Value);
   end Height;

   ------------
   -- Height --
   ------------

   overriding function Height (Sprite : in Sprite_Type) return Integer is
   begin
      return Sprite.Property ("height");
   end Height;

   -----------
   -- Scale --
   -----------

   procedure Scale (Sprite : in out Sprite_Type; Row, Column : in Positive) is
   begin
      Gnoga.Server.Connection.Execute_Script
        (Sprite.Connection_ID,
         "gnoga['" &
         Sprite.ID &
         "'].scale = {x:" &
         Column'Img &
         ",y:" &
         Row'Img &
         "};");
   end Scale;

   ---------------
   -- Row_Scale --
   ---------------

   function Row_Scale (Sprite : in Sprite_Type) return Positive is
   begin
      return Sprite.Property ("scale.y");
   end Row_Scale;

   ------------------
   -- Column_Scale --
   ------------------

   function Column_Scale (Sprite : in Sprite_Type) return Positive is
   begin
      return Sprite.Property ("scale.x");
   end Column_Scale;

   ----------
   -- Skew --
   ----------

   procedure Skew (Sprite : in out Sprite_Type; Row, Column : in Positive) is
   begin
      Gnoga.Server.Connection.Execute_Script
        (Sprite.Connection_ID,
         "gnoga['" &
         Sprite.ID &
         "'].skew = {x:" &
         Column'Img &
         ",y:" &
         Row'Img &
         "};");
   end Skew;

   --------------
   -- Row_Skew --
   --------------

   function Row_Skew (Sprite : in Sprite_Type) return Positive is
   begin
      return Sprite.Property ("skew.y");
   end Row_Skew;

   -----------------
   -- Column_Skew --
   -----------------

   function Column_Skew (Sprite : in Sprite_Type) return Positive is
   begin
      return Sprite.Property ("skew.x");
   end Column_Skew;

   -----------------
   -- Get_Texture --
   -----------------

   procedure Get_Texture
     (Sprite : in     Sprite_Type;
      Value  : in out Texture_Type'Class)
   is
      Texture_ID : constant String := Gnoga.Server.Connection.New_GID;
   begin
      Value.ID (Texture_ID, Gnoga.Types.Gnoga_ID);
      Value.Connection_ID (Sprite.Connection_ID);
      Gnoga.Server.Connection.Execute_Script
        (Sprite.Connection_ID,
         "gnoga['" & Texture_ID & "'] = gnoga['" & Sprite.ID & "'].texture;");
   end Get_Texture;

   -----------------
   -- Put_Texture --
   -----------------

   procedure Put_Texture
     (Sprite : in out Sprite_Type;
      Value  : in     Texture_Type'Class)
   is
   begin
      Gnoga.Server.Connection.Execute_Script
        (Sprite.Connection_ID,
         "gnoga['" & Sprite.ID & "'].texture = gnoga['" & Value.ID & "'];");
   end Put_Texture;

   ----------
   -- Tint --
   ----------

   procedure Tint (Sprite : in out Sprite_Type; Value : in Natural) is
   begin
      Sprite.Property ("tint", Value);
   end Tint;

   ----------
   -- Tint --
   ----------

   function Tint (Sprite : in Sprite_Type) return Natural is
   begin
      return Sprite.Property ("tint");
   end Tint;

   -------------
   -- Visible --
   -------------

   procedure Visible (Sprite : in out Sprite_Type; Value : in Boolean) is
   begin
      Sprite.Property ("visible", Value);
   end Visible;

   -------------
   -- Visible --
   -------------

   function Visible (Sprite : in Sprite_Type) return Boolean is
   begin
      return Sprite.Property ("visible");
   end Visible;

   -----------------
   -- Coincidence --
   -----------------

   function Coincidence
     (Sprite1, Sprite2 : in Sprite_Type;
      Tolerance        : in Natural) return Boolean
   is
   begin
      return Distance (Sprite1, Sprite2) <= Tolerance;
   end Coincidence;

   -----------------
   -- Coincidence --
   -----------------

   function Coincidence
     (Sprite      : in Sprite_Type;
      Row, Column : in Integer;
      Tolerance   : in Natural) return Boolean
   is
   begin
      return Distance (Sprite, Row, Column) <= Tolerance;
   end Coincidence;

   --------------
   -- Distance --
   --------------

   function Distance (Sprite1, Sprite2 : in Sprite_Type) return Natural is
   begin
      return Natural
          (Ada.Numerics.Elementary_Functions.Sqrt
             (Float (Sprite2.Row - Sprite1.Row)**2 +
              Float (Sprite2.Column - Sprite1.Column)**2));
   end Distance;

   --------------
   -- Distance --
   --------------

   function Distance
     (Sprite      : in Sprite_Type;
      Row, Column : in Integer) return Natural
   is
   begin
      return Natural
          (Ada.Numerics.Elementary_Functions.Sqrt
             (Float (Sprite.Row - Row)**2 +
              Float (Sprite.Column - Column)**2));
   end Distance;

   ------------
   -- Delete --
   ------------

   procedure Delete
     (Sprite : in out Sprite_Type;
      Parent : in out Container_Type'Class)
   is
   begin
      Parent.Remove_Child (Sprite);
   end Delete;

   ----------------
   -- Delete_All --
   ----------------

   procedure Delete_All (Parent : in out Container_Type'Class) is

   begin
      Gnoga.Server.Connection.Execute_Script
        (Parent.Connection_ID,
         "var gnoga_list = [];" &
         " for (var gnoga_sprite of gnoga['" &
         Parent.ID &
         "'].children) if (gnoga_sprite instanceof PIXI.Sprite) gnoga_list.push(gnoga_sprite);" &
         " for (var gnoga_sprite of gnoga_list)" &
         " gnoga['" &
         Parent.ID &
         "'].removeChild(gnoga_sprite);");
   end Delete_All;

end Gnoga.Gui.Plugin.Pixi.Sprite;