#include "ppu.h"
#include "ppu_instruction_formats.h"


void PPU_Init() {

}


void PPU_SetViewportOffset(uint16_t x, uint16_t y) {
  SetViewportOffsetInstruction instr = { 0 };
  instr.fields.opCode = OPCODE_SETVIEWPORTOFFSET;
  instr.fields.viewportOffsetX = x;
  instr.fields.viewportOffsetY = y;

  MYCUCKREGISTER_mWriteReg(XPAR_MYCUCKREGISTER_0_S00_AXI_BASEADDR, 0, instr.instruction);
}


void PPU_SetBackgroundTileID(uint8_t tileColIndex, uint8_t tileRowIndex, uint8_t tileID) {
  SetBackgroundTileIDInstruction instr = { 0 };
  instr.fields.opCode = OPCODE_SETBACKGROUNDTILEID;
  instr.fields.tileColIndex = tileColIndex;
  instr.fields.tileRowIndex = tileRowIndex;
  instr.fields.tileID = tileID;

  MYCUCKREGISTER_mWriteReg(XPAR_MYCUCKREGISTER_0_S00_AXI_BASEADDR, 0, instr.instruction);
}


void PPU_SetBackgroundTileColor(uint8_t pixelColIndex, uint8_t pixelRowIndex, uint8_t tileID, uint8_t pixelColorCode) {
  SetActorTileColorInstruction instr = { 0 };
  instr.fields.opCode = OPCODE_SETBACKGROUNDTILECOLOR;
  instr.fields.pixelColIndex = pixelColIndex;
  instr.fields.pixelRowIndex = pixelRowIndex;
  instr.fields.tileID = tileID;
  instr.fields.pixelColorCode = pixelColorCode;

  MYCUCKREGISTER_mWriteReg(XPAR_MYCUCKREGISTER_0_S00_AXI_BASEADDR, 0, instr.instruction);
}


void PPU_SetActorTileID(uint8_t actorID, uint8_t tileID) {
  SetActorTileIDInstruction instr = { 0 };
  instr.fields.opCode = OPCODE_SETACTORTILEID;
  instr.fields.actorID = actorID;
  instr.fields.tileID = tileID;

  MYCUCKREGISTER_mWriteReg(XPAR_MYCUCKREGISTER_0_S00_AXI_BASEADDR, 0, instr.instruction);
}


void PPU_SetActorTileColor(uint8_t pixelColIndex, uint8_t pixelRowIndex, uint8_t tileID, uint8_t pixelColorCode) {
  SetActorTileColorInstruction instr = { 0 };
  instr.fields.opCode = OPCODE_SETACTORTILECOLOR;
  instr.fields.pixelColIndex = pixelColIndex;
  instr.fields.pixelRowIndex = pixelRowIndex;
  instr.fields.tileID = tileID;
  instr.fields.pixelColorCode = pixelColorCode;

  MYCUCKREGISTER_mWriteReg(XPAR_MYCUCKREGISTER_0_S00_AXI_BASEADDR, 0, instr.instruction);
}


void PPU_SetActorPosition(uint16_t x, uint16_t y, uint8_t actorID) {
  SetActorPositionInstruction instr = { 0 };
  instr.fields.opCode = OPCODE_SETACTORPOSITION;
  instr.fields.x = x;
  instr.fields.y = y;
  instr.fields.actorID = actorID;

  MYCUCKREGISTER_mWriteReg(XPAR_MYCUCKREGISTER_0_S00_AXI_BASEADDR, 0, instr.instruction);
}


void PPU_MoveActorPosition(uint8_t deltaX, uint8_t deltaY, uint8_t actorID) {
  MoveActorPositionInstruction instr = { 0 };
  instr.fields.opCode = OPCODE_MOVEACTORPOSITION;
  instr.fields.deltaX = deltaX;
  instr.fields.deltaY = deltaY;
  instr.fields.actorID = actorID;

  MYCUCKREGISTER_mWriteReg(XPAR_MYCUCKREGISTER_0_S00_AXI_BASEADDR, 0, instr.instruction);
}
