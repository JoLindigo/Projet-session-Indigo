#include "ppu.h"
#include "ppu_instruction_formats.h"


void PPU_Init() {

}


void PPU_SetViewportOffset(uint16_t x, uint16_t y) {
  Xil_AssertVoid(x <= UINT_10_VALUE_MAX && "Value of parameter x must fit in 10 bits.");
  Xil_AssertVoid(y <= UINT_10_VALUE_MAX && "Value of parameter y must fit in 10 bits.");

  SetViewportOffsetInstruction instr = { 0 };
  instr.fields.opCode = OPCODE_SETVIEWPORTOFFSET;
  instr.fields.viewportOffsetX = x;
  instr.fields.viewportOffsetY = y;

  MYCUCKREGISTER_mWriteReg(XPAR_MYCUCKREGISTER_0_S00_AXI_BASEADDR, 0, instr.instruction);
}


void PPU_SetBackgroundTileID(uint8_t tileColIndex, uint8_t tileRowIndex, uint8_t tileID) {
  Xil_AssertVoid(tileColIndex <= UINT_7_VALUE_MAX && "Value of parameter tileColIndex must fit in 7 bits.");
  Xil_AssertVoid(tileRowIndex <= UINT_7_VALUE_MAX && "Value of parameter tileRowIndex must fit in 7 bits.");
  Xil_AssertVoid(tileID <= UINT_6_VALUE_MAX && "Value of parameter tileID must fit in 6 bits.");

  SetBackgroundTileIDInstruction instr = { 0 };
  instr.fields.opCode = OPCODE_SETBACKGROUNDTILEID;
  instr.fields.tileColIndex = tileColIndex;
  instr.fields.tileRowIndex = tileRowIndex;
  instr.fields.tileID = tileID;

  MYCUCKREGISTER_mWriteReg(XPAR_MYCUCKREGISTER_0_S00_AXI_BASEADDR, 0, instr.instruction);
}


void PPU_SetBackgroundTileColor(uint8_t pixelColIndex, uint8_t pixelRowIndex, uint8_t tileID, uint8_t pixelColorCode) {
  Xil_AssertVoid(pixelColIndex <= UINT_3_VALUE_MAX && "Value of parameter pixelColIndex must fit in 3 bits.");
  Xil_AssertVoid(pixelRowIndex <= UINT_3_VALUE_MAX && "Value of parameter pixelRowIndex must fit in 3 bits.");
  Xil_AssertVoid(tileID <= UINT_6_VALUE_MAX && "Value of parameter tileID must fit in 6 bits.");
  Xil_AssertVoid(pixelColorCode <= UINT_5_VALUE_MAX && "Value of parameter pixelColorCode must fit in 5 bits.");

  SetActorTileColorInstruction instr = { 0 };
  instr.fields.opCode = OPCODE_SETBACKGROUNDTILECOLOR;
  instr.fields.pixelColIndex = pixelColIndex;
  instr.fields.pixelRowIndex = pixelRowIndex;
  instr.fields.tileID = tileID;
  instr.fields.pixelColorCode = pixelColorCode;

  MYCUCKREGISTER_mWriteReg(XPAR_MYCUCKREGISTER_0_S00_AXI_BASEADDR, 0, instr.instruction);
}


void PPU_SetActorTileID(uint8_t actorID, uint8_t tileID) {
  Xil_AssertVoid(actorID <= UINT_3_VALUE_MAX && "Value of parameter actorID must fit in 3 bits.");
  Xil_AssertVoid(tileID <= UINT_6_VALUE_MAX && "Value of parameter tileID must fit in 6 bits.");

  SetActorTileIDInstruction instr = { 0 };
  instr.fields.opCode = OPCODE_SETACTORTILEID;
  instr.fields.actorID = actorID;
  instr.fields.tileID = tileID;

  MYCUCKREGISTER_mWriteReg(XPAR_MYCUCKREGISTER_0_S00_AXI_BASEADDR, 0, instr.instruction);
}


void PPU_SetActorTileColor(uint8_t pixelColIndex, uint8_t pixelRowIndex, uint8_t tileID, uint8_t pixelColorCode) {
  Xil_AssertVoid(pixelColIndex <= UINT_4_VALUE_MAX && "Value of parameter pixelColIndex must fit in 4 bits.");
  Xil_AssertVoid(pixelRowIndex <= UINT_4_VALUE_MAX && "Value of parameter pixelRowIndex must fit in 4 bits.");
  Xil_AssertVoid(tileID <= UINT_6_VALUE_MAX && "Value of parameter tileID must fit in 6 bits.");
  Xil_AssertVoid(pixelColorCode <= UINT_5_VALUE_MAX && "Value of parameter pixelColorCode must fit in 5 bits.");

  SetActorTileColorInstruction instr = { 0 };
  instr.fields.opCode = OPCODE_SETACTORTILECOLOR;
  instr.fields.pixelColIndex = pixelColIndex;
  instr.fields.pixelRowIndex = pixelRowIndex;
  instr.fields.tileID = tileID;
  instr.fields.pixelColorCode = pixelColorCode;

  MYCUCKREGISTER_mWriteReg(XPAR_MYCUCKREGISTER_0_S00_AXI_BASEADDR, 0, instr.instruction);
}


void PPU_SetActorPosition(uint16_t x, uint16_t y, uint8_t actorID) {
  Xil_AssertVoid(x <= UINT_10_VALUE_MAX && "Value of parameter x must fit in 10 bits.");
  Xil_AssertVoid(y <= UINT_10_VALUE_MAX && "Value of parameter y must fit in 10 bits.");
  Xil_AssertVoid(actorID <= UINT_3_VALUE_MAX && "Value of parameter actorID must fit in 3 bits.");

  SetActorPositionInstruction instr = { 0 };
  instr.fields.opCode = OPCODE_SETACTORPOSITION;
  instr.fields.x = x;
  instr.fields.y = y;
  instr.fields.actorID = actorID;

  MYCUCKREGISTER_mWriteReg(XPAR_MYCUCKREGISTER_0_S00_AXI_BASEADDR, 0, instr.instruction);
}


void PPU_MoveActorPosition(uint8_t deltaX, uint8_t deltaY, uint8_t actorID) {
  Xil_AssertVoid(deltaX <= UINT_10_VALUE_MAX && "Value of parameter deltaX must fit in 10 bits.");
  Xil_AssertVoid(deltaY <= UINT_10_VALUE_MAX && "Value of parameter deltaY must fit in 10 bits.");
  Xil_AssertVoid(actorID <= UINT_3_VALUE_MAX && "Value of parameter actorID must fit in 3 bits.");

  MoveActorPositionInstruction instr = { 0 };
  instr.fields.opCode = OPCODE_MOVEACTORPOSITION;
  instr.fields.deltaX = deltaX;
  instr.fields.deltaY = deltaY;
  instr.fields.actorID = actorID;

  MYCUCKREGISTER_mWriteReg(XPAR_MYCUCKREGISTER_0_S00_AXI_BASEADDR, 0, instr.instruction);
}
