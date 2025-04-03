import numpy as np
import os
import png

from PIL import Image
from constants import CURRENT_DIR

hex_colors_to_ppu_color_codes = {
  "0x000000": "00000",
  "0x9b8787": "00001",
  "0xac3232": "00010"
}

def convert_sprite_to_ppu_instructions(file_name: str):
  file_exists = os.path.exists(os.path.join(CURRENT_DIR, file_name))
  if not file_exists:
    raise FileNotFoundError("Provided file does not exist on the system.")
    
  reader = png.Reader(filename=os.path.join(CURRENT_DIR, file_name))
  width, height, pixels, metadata = reader.read_flat()
  pixel_byte_width = 4 if metadata['alpha'] else 3
  pixels_ndarray = np.array(list(pixels), dtype=np.uint8).reshape((height, width, pixel_byte_width))

  with open(os.path.join(CURRENT_DIR, f"{file_name.split('.png')[0]}_tile_id_instructions.txt"), 'w') as tile_id_inst_file, \
       open(os.path.join(CURRENT_DIR, f"{file_name.split('.png')[0]}_tile_color_instructions.txt"), 'w') as tile_color_inst_file:
    tile_id_inst_file.write("u32 tile_id_instructions[] = {")
    tile_color_inst_file.write("u32 tile_color_instructions[] = {")
    
    tile_id_instruction_builder = ""

    for i in range(0, 64):
      for j in range(0, 128):
        if j != 0 or i > 0:
          tile_id_inst_file.write(',')

        tile_id_inst_file.write("\n")

        tile_id_instruction_builder += "    0b0100"
        tile_id_instruction_builder += "00001"
        tile_id_instruction_builder += f"{j:07b}"
        tile_id_instruction_builder += f"{i:06b}"
        tile_id_instruction_builder += "0000000000"

        tile_id_inst_file.write(tile_id_instruction_builder)
        tile_id_instruction_builder = ""
        
    tile_color_instruction_builder = ""        

    for row in range(height):
      for col in range(width):
        if col != 0 or row > 0:
          tile_color_inst_file.write(',')
          
        tile_color_inst_file.write("\n")
        
        if metadata['alpha']:
          r, g, b, _ = pixels_ndarray[row][col]
          pixel_data_str = hex(r) + hex(g)[2:] + hex(b)[2:]
        else:
          r, g, b = pixels_ndarray[row][col]
          pixel_data_str += hex(r) + hex(g)[2:] + hex(b)[2:]
                
        tile_color_instruction_builder += "    0b0010"
        tile_color_instruction_builder += "00001"
        tile_color_instruction_builder += f"{col:03b}"
        tile_color_instruction_builder += f"{row:03b}"
        tile_color_instruction_builder += hex_colors_to_ppu_color_codes[pixel_data_str]
        tile_color_instruction_builder += "000000000000"        
        
        tile_color_inst_file.write(tile_color_instruction_builder)
        tile_color_instruction_builder = ""
      
    tile_id_inst_file.write("\n};")
    tile_color_inst_file.write("\n};")


def convert_sprite_to_pixel_array(file_name: str):
  file_exists = os.path.exists(os.path.join(CURRENT_DIR, file_name))
  if not file_exists:
    raise FileNotFoundError("Provided file does not exist on the system.")
  
  reader = png.Reader(filename=os.path.join(CURRENT_DIR, file_name))
  _, _, pixels, metadata = reader.read_flat()
  pixel_byte_width = 4 if metadata['alpha'] else 3
  
  with open(os.path.join(CURRENT_DIR, f"{file_name.split('.png')[0]}_out.txt"), 'w') as output_file:
    output_file.write("int sprite_frame_colors[] {")
    
    for i in range(0, len(pixels), pixel_byte_width):
      if i != 0:
        output_file.write(',')
        
      output_file.write("\n")
      pixel = pixels[i:i+pixel_byte_width]
      pixel_data_str = "    0x"
      
      for p in pixel:
        pixel_data_str += hex(p)[2:]
        
      pixel_data_str_split = pixel_data_str.split('x')
              
      if len(pixel_data_str_split[1]) == 4:
        pixel_data_str = pixel_data_str_split[0] + "x0000" + pixel_data_str_split[1]
      elif len(pixel_data_str_split[1]) == 5:
        pixel_data_str = pixel_data_str_split[0] + "x000" + pixel_data_str_split[1]
        
      output_file.write(pixel_data_str)
    output_file.write("\n}")

def is_hex_rgba_null(rgba_hex_code: str) -> bool:
  return rgba_hex_code == "0x00000000"