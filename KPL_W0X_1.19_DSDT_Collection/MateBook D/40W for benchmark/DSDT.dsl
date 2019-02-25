DefinitionBlock ("DSDT.aml", "DSDT", 1, "HUAWEI", "Tambouri", 0x00040001)
{
    External (_SB_.APTS, MethodObj)
    External (_SB_.AWAK, MethodObj)
    External (_SB_.TPM2.PTS_, MethodObj)
    External (_SB_.UBTC.M318, MethodObj)
    External (A012, MethodObj)
    External (AFN4, MethodObj)
    External (AFN7, MethodObj)
    External (ALIB, MethodObj)
    External (MPTS, MethodObj)
    External (MWAK, MethodObj)

    External (_PR_.C000.PPCV, UnknownObj)
    External (_PR_.C001.PPCV, UnknownObj)
    External (_PR_.C002.PPCV, UnknownObj)
    External (_PR_.C003.PPCV, UnknownObj)
    External (_PR_.C004.PPCV, UnknownObj)
    External (_PR_.C005.PPCV, UnknownObj)
    External (_PR_.C006.PPCV, UnknownObj)
    External (_PR_.C007.PPCV, UnknownObj)
    External (_SB_.WMI1, UnknownObj)
    External (_SB_.WMI1.WMEN, UnknownObj)
    External (AUEN, IntObj)
    External (BTEN, IntObj)
    External (CAEN, IntObj)
    External (DAIN, UnknownObj)
    External (DAOU, IntObj)
    External (HDEN, IntObj)
    External (KSVA, IntObj)
    External (OWUS, IntObj)
    External (PDEN, IntObj)
    External (SEBO, IntObj)
    External (TPCM, IntObj)
    External (UBTC, UnknownObj)
    External (WFEN, IntObj)
    External (WMI1, UnknownObj)

    Method (GET9, 2, NotSerialized)
    {
        CreateByteField (Arg0, Arg1, TCH9)
        Return (TCH9) /* \GET9.TCH9 */
    }

    Method (STR9, 2, NotSerialized)
    {
        Name (STR8, Buffer (0x50) {})
        Name (STR9, Buffer (0x50) {})
        Store (Arg0, STR8) /* \STR9.STR8 */
        Store (Arg1, STR9) /* \STR9.STR9 */
        Store (Zero, Local0)
        Store (One, Local1)
        While (Local1)
        {
            Store (GET9 (STR8, Local0), Local1)
            Store (GET9 (STR9, Local0), Local2)
            If (LNotEqual (Local1, Local2))
            {
                Return (Zero)
            }

            Increment (Local0)
        }

        Return (One)
    }

    OperationRegion (SPRT, SystemIO, 0xB0, 0x02)
    Field (SPRT, ByteAcc, Lock, Preserve)
    {
        SSMP,   8
    }

    Method (HSMI, 0, NotSerialized)
    {
        Store (0xC1, SSMP) /* \SSMP */
    }

    Method (USMI, 0, NotSerialized)
    {
        Store (0xC5, SSMP) /* \SSMP */
    }

    Method (UEMI, 0, NotSerialized)
    {
        Store (0xC6, SSMP) /* \SSMP */
    }

    Method (GVER, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        CreateByteField (BUFF, One, BMJV)
        CreateByteField (BUFF, 0x03, BMNV)
        Store (Zero, STAT) /* \GVER.STAT */
        Store (One, BMJV) /* \GVER.BMJV */
        Store (0x03, BMNV) /* \GVER.BMNV */
        Return (BUFF) /* \GVER.BUFF */
    }

    Method (GTSI, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        CreateByteField (BUFF, One, TSI1)
        CreateByteField (BUFF, 0x02, TSI2)
        Store (Zero, STAT) /* \GTSI.STAT */
        Store (0xA1, TSI1) /* \GTSI.TSI1 */
        Store (0x49, TSI2) /* \GTSI.TSI2 */
        Return (BUFF) /* \GTSI.BUFF */
    }

    Method (GTMP, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (Arg0, 0x02, TEPE)
        CreateByteField (BUFF, Zero, STAT)
        CreateByteField (BUFF, One, TEM0)
        CreateByteField (BUFF, 0x02, TEM1)
        CreateByteField (BUFF, 0x03, TEM2)
        Store (Zero, STAT) /* \GTMP.STAT */
        If (LEqual (TEPE, Zero))
        {
            Store (\_SB.PCI0.LPC0.EC0.CTMP, Local1)
        }
        Else
        {
            If (LEqual (TEPE, 0x05))
            {
                Store (\_SB.PCI0.LPC0.EC0.STM0, Local1)
            }
            Else
            {
                If (LEqual (TEPE, 0x07))
                {
                    Store (\_SB.PCI0.LPC0.EC0.TNTC, Local1)
                }
                Else
                {
                    If (LEqual (TEPE, 0x08))
                    {
                        Store (\_SB.PCI0.LPC0.EC0.CNTC, Local1)
                    }
                    Else
                    {
                        If (LEqual (TEPE, 0x0B))
                        {
                            Store (\_SB.PCI0.LPC0.EC0.DNTC, Local1)
                        }
                        Else
                        {
                            If (LEqual (TEPE, 0x0E))
                            {
                                Store (\_SB.PCI0.LPC0.EC0.BTMP, Local1)
                            }
                            Else
                            {
                                Store (0xFF, Local1)
                            }
                        }
                    }
                }
            }
        }

        If (LEqual (Local1, 0xFF))
        {
            Store (One, STAT) /* \GTMP.STAT */
        }

        Store (Local1, TEM1) /* \GTMP.TEM1 */
        Store (Zero, TEM0) /* \GTMP.TEM0 */
        Store (Zero, TEM2) /* \GTMP.TEM2 */
        Return (BUFF) /* \GTMP.BUFF */
    }

    Method (STMT, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        CreateByteField (Arg0, 0x02, SSRN)
        CreateByteField (Arg0, 0x05, TUPL)
        CreateByteField (Arg0, 0x07, TDNL)
        Store (Zero, Local1)
        If (LGreater (TDNL, TUPL))
        {
            Store (0xFF, Local1)
        }

        If (LEqual (Local1, Zero))
        {
            If (LEqual (SSRN, Zero))
            {
                Store (TUPL, \_SB.PCI0.LPC0.EC0.UCPU)
                Store (TDNL, \_SB.PCI0.LPC0.EC0.DCPU)
                Store (Zero, \_SB.PCI0.LPC0.EC0.CPUF)
                Store (Zero, \_SB.PCI0.LPC0.EC0.CPDF)
                Store (Zero, \_SB.PCI0.LPC0.EC0.TFUC)
                Store (Zero, \_SB.PCI0.LPC0.EC0.TFDC)
            }
            Else
            {
                If (LEqual (SSRN, 0x05))
                {
                    Store (TUPL, \_SB.PCI0.LPC0.EC0.UGPE)
                    Store (TDNL, \_SB.PCI0.LPC0.EC0.DGPE)
                    Store (Zero, \_SB.PCI0.LPC0.EC0.GPUF)
                    Store (Zero, \_SB.PCI0.LPC0.EC0.GPDF)
                    Store (Zero, \_SB.PCI0.LPC0.EC0.TFUG)
                    Store (Zero, \_SB.PCI0.LPC0.EC0.TFDG)
                }
                Else
                {
                    If (LEqual (SSRN, 0x07))
                    {
                        Store (TUPL, \_SB.PCI0.LPC0.EC0.UTYC)
                        Store (TDNL, \_SB.PCI0.LPC0.EC0.DTYC)
                        Store (Zero, \_SB.PCI0.LPC0.EC0.TCUF)
                        Store (Zero, \_SB.PCI0.LPC0.EC0.TCDF)
                        Store (Zero, \_SB.PCI0.LPC0.EC0.TFUT)
                        Store (Zero, \_SB.PCI0.LPC0.EC0.TFDT)
                    }
                    Else
                    {
                        If (LEqual (SSRN, 0x08))
                        {
                            Store (TUPL, \_SB.PCI0.LPC0.EC0.UCHA)
                            Store (TDNL, \_SB.PCI0.LPC0.EC0.DCHA)
                            Store (Zero, \_SB.PCI0.LPC0.EC0.CHUF)
                            Store (Zero, \_SB.PCI0.LPC0.EC0.CHDF)
                            Store (Zero, \_SB.PCI0.LPC0.EC0.TFUH)
                            Store (Zero, \_SB.PCI0.LPC0.EC0.TFDH)
                        }
                        Else
                        {
                            If (LEqual (SSRN, 0x0B))
                            {
                                Store (TUPL, \_SB.PCI0.LPC0.EC0.UDDR)
                                Store (TDNL, \_SB.PCI0.LPC0.EC0.DDDR)
                                Store (Zero, \_SB.PCI0.LPC0.EC0.DRUF)
                                Store (Zero, \_SB.PCI0.LPC0.EC0.DRDF)
                                Store (Zero, \_SB.PCI0.LPC0.EC0.TFUD)
                                Store (Zero, \_SB.PCI0.LPC0.EC0.TFDD)
                            }
                        }
                    }
                }
            }

            Store (Zero, STAT) /* \STMT.STAT */
        }
        Else
        {
            Store (One, STAT) /* \STMT.STAT */
        }

        Return (BUFF) /* \STMT.BUFF */
    }

    Method (GPSI, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        CreateByteField (BUFF, One, PSIT)
        Store (0x05, PSIT) /* \GPSI.PSIT */
        Store (Zero, STAT) /* \GPSI.STAT */
        Return (BUFF) /* \GPSI.BUFF */
    }

    Method (GPCI, 1, Serialized)
    {
        Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
        Name (BUFF, Buffer (0x0100) {})
        Name (IADP, Zero)
        Name (IBAT, Zero)
        Name (VBAT, Zero)
        CreateByteField (BUFF, Zero, STAT)
        CreateByteField (BUFF, One, POVA)
        CreateByteField (Arg0, 0x02, GTST)
        Store (Zero, STAT) /* \GPCI.STAT */
        While (One)
        {
            Store (ToInteger (GTST), _T_0) /* \GPCI._T_0 */
            If (LEqual (_T_0, Zero))
            {
                Store (Zero, Local1)
                Store (\_SB.PCI0.LPC0.EC0.PADH, IADP) /* \GPCI.IADP */
                ShiftLeft (IADP, 0x08, IADP) /* \GPCI.IADP */
                Or (\_SB.PCI0.LPC0.EC0.PADL, IADP, IADP) /* \GPCI.IADP */
                Multiply (IADP, 0x023A, Local1)
                Divide (Local1, 0x07D0, , Local1)
                Store (Local1, POVA) /* \GPCI.POVA */
            }
            Else
            {
                If (LEqual (_T_0, 0x02))
                {
                    Store (Zero, Local1)
                    Store (\_SB.PCI0.LPC0.EC0.PBTH, IBAT) /* \GPCI.IBAT */
                    ShiftLeft (IBAT, 0x08, IBAT) /* \GPCI.IBAT */
                    Or (\_SB.PCI0.LPC0.EC0.PBTL, IBAT, IBAT) /* \GPCI.IBAT */
                    Store (\_SB.PCI0.LPC0.EC0.BT1V, VBAT) /* \GPCI.VBAT */
                    Multiply (IBAT, 0x0F, IBAT) /* \GPCI.IBAT */
                    Multiply (IBAT, VBAT, Local1)
                    Divide (Local1, 0x000F4240, , Local1)
                    Store (Local1, POVA) /* \GPCI.POVA */
                }
                Else
                {
                    Store (Zero, POVA) /* \GPCI.POVA */
                    Store (One, STAT) /* \GPCI.STAT */
                }
            }

            Break
        }

        If (LEqual (POVA, Zero))
        {
            Store (One, STAT) /* \GPCI.STAT */
        }

        Return (BUFF) /* \GPCI.BUFF */
    }

    Method (GLIV, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        Store (Zero, STAT) /* \GLIV.STAT */
        Return (BUFF) /* \GLIV.BUFF */
    }

    Method (SLIV, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        Store (Zero, STAT) /* \SLIV.STAT */
        Return (BUFF) /* \SLIV.BUFF */
    }

    Method (GFNS, 1, Serialized)
    {
        Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (Arg0, 0x02, FANN)
        CreateByteField (BUFF, Zero, STAT)
        CreateByteField (BUFF, One, FANL)
        CreateByteField (BUFF, 0x02, FANH)
        Store (Zero, STAT) /* \GFNS.STAT */
        While (One)
        {
            Store (ToInteger (FANN), _T_0) /* \GFNS._T_0 */
            If (LEqual (_T_0, Zero))
            {
                Store (\_SB.PCI0.LPC0.EC0.FRHI, FANH) /* \GFNS.FANH */
                Store (\_SB.PCI0.LPC0.EC0.FRLO, FANL) /* \GFNS.FANL */
            }
            Else
            {
                If (LEqual (_T_0, One)) {}
                Else
                {
                    If (LEqual (_T_0, 0x02)) {}
                    Else
                    {
                        If (LEqual (_T_0, 0x03)) {}
                        Else
                        {
                            Store (Zero, FANH) /* \GFNS.FANH */
                            Store (Zero, FANL) /* \GFNS.FANL */
                        }
                    }
                }
            }

            Break
        }

        Return (BUFF) /* \GFNS.BUFF */
    }

    Method (GCVA, 1, Serialized)
    {
        Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
        Name (BUFF, Buffer (0x0100) {})
        Name (BCVF, Zero)
        Name (BCVT, Zero)
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        CreateByteField (BUFF, One, GCV1)
        CreateWordField (BUFF, 0x02, GCV2)
        CreateByteField (Arg0, 0x02, GCIN)
        Store (Zero, STAT) /* \GCVA.STAT */
        While (One)
        {
            Store (ToInteger (GCIN), _T_0) /* \GCVA._T_0 */
            If (LEqual (_T_0, 0x20))
            {
                Store (Zero, GCV1) /* \GCVA.GCV1 */
                Store (\_SB.PCI0.LPC0.EC0.BT1V, GCV2) /* \GCVA.GCV2 */
            }
            Else
            {
                If (LEqual (_T_0, 0x30))
                {
                    Store (Zero, Local1)
                    Store (\_SB.PCI0.LPC0.EC0.BT1I, BCVF) /* \GCVA.BCVF */
                    If (LGreaterEqual (BCVF, 0x8000))
                    {
                        Store (One, GCV1) /* \GCVA.GCV1 */
                        Not (BCVF, BCVT) /* \GCVA.BCVT */
                        Add (BCVT, One, GCV2) /* \GCVA.GCV2 */
                    }
                    Else
                    {
                        Store (Zero, GCV1) /* \GCVA.GCV1 */
                        Store (BCVF, GCV2) /* \GCVA.GCV2 */
                    }
                }
                Else
                {
                    Store (Zero, GCV1) /* \GCVA.GCV1 */
                    Store (Zero, GCV2) /* \GCVA.GCV2 */
                    Store (One, STAT) /* \GCVA.STAT */
                }
            }

            Break
        }

        Return (BUFF) /* \GCVA.BUFF */
    }

    Method (GFRQ, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        Store (Zero, STAT) /* \GFRQ.STAT */
        Return (BUFF) /* \GFRQ.BUFF */
    }

    Method (SPSL, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        Store (Zero, STAT) /* \SPSL.STAT */
        CreateByteField (Local0, 0x02, BFPP)
        If (LLessEqual (BFPP, 0x02))
        {
            Store (BFPP, \_PR.C000.PPCV) /* External reference */
            Notify (\_PR.C000, 0x80) // Performance Capability Change
            Sleep (0x64)
            Store (BFPP, \_PR.C001.PPCV) /* External reference */
            Notify (\_PR.C001, 0x80) // Performance Capability Change
            Sleep (0x64)
            Store (BFPP, \_PR.C002.PPCV) /* External reference */
            Notify (\_PR.C002, 0x80) // Performance Capability Change
            Sleep (0x64)
            Store (BFPP, \_PR.C003.PPCV) /* External reference */
            Notify (\_PR.C003, 0x80) // Performance Capability Change
            Sleep (0x64)
            Store (BFPP, \_PR.C004.PPCV) /* External reference */
            Notify (\_PR.C004, 0x80) // Performance Capability Change
            Sleep (0x64)
            Store (BFPP, \_PR.C005.PPCV) /* External reference */
            Notify (\_PR.C005, 0x80) // Performance Capability Change
            Sleep (0x64)
            Store (BFPP, \_PR.C006.PPCV) /* External reference */
            Notify (\_PR.C006, 0x80) // Performance Capability Change
            Sleep (0x64)
            Store (BFPP, \_PR.C007.PPCV) /* External reference */
            Notify (\_PR.C007, 0x80) // Performance Capability Change
            Sleep (0x64)
        }
        Else
        {
            Store (One, STAT) /* \SPSL.STAT */
        }

        Return (BUFF) /* \SPSL.BUFF */
    }

    Method (RDTB, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        Store (Zero, STAT) /* \RDTB.STAT */
        Store (Local0, DAIN) /* External reference */
        HSMI ()
        Store (DAOU, BUFF) /* \RDTB.BUFF */
        Return (BUFF) /* \RDTB.BUFF */
    }

    Method (STTB, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        Store (Zero, STAT) /* \STTB.STAT */
        Store (Local0, DAIN) /* External reference */
        HSMI ()
        Store (DAOU, BUFF) /* \STTB.BUFF */
        Return (BUFF) /* \STTB.BUFF */
    }

    Method (GHWP, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        Store (Zero, STAT) /* \GHWP.STAT */
        Store (Local0, DAIN) /* External reference */
        HSMI ()
        Store (DAOU, BUFF) /* \GHWP.BUFF */
        Return (BUFF) /* \GHWP.BUFF */
    }

    Method (SHWP, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        Store (Zero, STAT) /* \SHWP.STAT */
        Store (Local0, DAIN) /* External reference */
        HSMI ()
        Store (DAOU, BUFF) /* \SHWP.BUFF */
        Return (BUFF) /* \SHWP.BUFF */
    }

    Method (GEEP, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        Store (Zero, STAT) /* \GEEP.STAT */
        Store (Local0, DAIN) /* External reference */
        HSMI ()
        Store (DAOU, BUFF) /* \GEEP.BUFF */
        Return (BUFF) /* \GEEP.BUFF */
    }

    Method (SEEP, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        Store (Zero, STAT) /* \SEEP.STAT */
        Store (Local0, DAIN) /* External reference */
        HSMI ()
        Store (DAOU, BUFF) /* \SEEP.BUFF */
        Return (BUFF) /* \SEEP.BUFF */
    }

    Method (GTDP, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        Store (Zero, STAT) /* \GTDP.STAT */
        Store (Local0, DAIN) /* External reference */
        HSMI ()
        Store (DAOU, BUFF) /* \GTDP.BUFF */
        Return (BUFF) /* \GTDP.BUFF */
    }

    Method (STDP, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        Store (Zero, STAT) /* \STDP.STAT */
        Store (Local0, DAIN) /* External reference */
        HSMI ()
        Store (DAOU, BUFF) /* \STDP.BUFF */
        Return (BUFF) /* \STDP.BUFF */
    }

    Method (GCPL, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        Store (Zero, STAT) /* \GCPL.STAT */
        Return (BUFF) /* \GCPL.BUFF */
    }

    Method (SPLV, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        Store (Zero, STAT) /* \SPLV.STAT */
        Return (BUFF) /* \SPLV.BUFF */
    }

    Method (GODP, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        Store (Zero, STAT) /* \GODP.STAT */
        Store (Local0, DAIN) /* External reference */
        HSMI ()
        Store (DAOU, BUFF) /* \GODP.BUFF */
        Return (BUFF) /* \GODP.BUFF */
    }

    Method (SODP, 1, Serialized)
    {
        Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        Store (Zero, STAT) /* \SODP.STAT */
        CreateByteField (Arg0, 0x02, ODVN)
        CreateByteField (Arg0, 0x03, ACIR)
        If (LLessEqual (ACIR, 0x3F))
        {
            If (LLessEqual (ODVN, 0x05))
            {
                While (One)
                {
                    Store (ToInteger (ODVN), _T_0) /* \SODP._T_0 */
                    If (LEqual (_T_0, Zero))
                    {
                        If (LEqual (ACIR, 0x02))
                        {
                            Store (One, \_SB.PCI0.LPC0.EC0.SPMD)
                        }
                        Else
                        {
                            Store (Zero, \_SB.PCI0.LPC0.EC0.SPMD)
                        }

                        Break
                    }

                    Break
                }
            }
        }

        Return (BUFF) /* \SODP.BUFF */
    }

    Method (SBTT, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (Arg0, 0x02, BCLB)
        CreateByteField (Arg0, 0x03, BCHB)
        CreateByteField (BUFF, Zero, STAT)
        Store (Zero, STAT) /* \SBTT.STAT */
        Store (BCLB, \_SB.PCI0.LPC0.EC0.BCCL)
        Store (BCHB, \_SB.PCI0.LPC0.EC0.BCCH)
        Return (BUFF) /* \SBTT.BUFF */
    }

    Method (GBTT, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        CreateByteField (BUFF, One, GLCP)
        CreateByteField (BUFF, 0x02, GHCP)
        Store (Zero, STAT) /* \GBTT.STAT */
        Store (\_SB.PCI0.LPC0.EC0.BCCL, GLCP) /* \GBTT.GLCP */
        Store (\_SB.PCI0.LPC0.EC0.BCCH, GHCP) /* \GBTT.GHCP */
        Return (BUFF) /* \GBTT.BUFF */
    }

    Method (STSL, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        Store (Zero, STAT) /* \STSL.STAT */
        Return (BUFF) /* \STSL.BUFF */
    }

    Method (GGDS, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        Store (Zero, STAT) /* \GGDS.STAT */
        Return (BUFF) /* \GGDS.BUFF */
    }

    Method (SCRP, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        Store (Zero, STAT) /* \SCRP.STAT */
        Return (BUFF) /* \SCRP.BUFF */
    }

    Method (PAFS, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        CreateByteField (BUFF, One, PAFS)
        Store (Zero, STAT) /* \PAFS.STAT */
        If (LEqual (\_SB.PCI0.LPC0.EC0.LPBF, One))
        {
            Store (One, PAFS) /* \PAFS.PAFS */
        }
        Else
        {
            Store (0x02, PAFS) /* \PAFS.PAFS */
        }

        Return (BUFF) /* \PAFS.BUFF */
    }

    Method (PAFF, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        CreateByteField (Arg0, 0x02, PAFR)
        Store (Zero, STAT) /* \PAFF.STAT */
        If (LEqual (PAFR, One))
        {
            Store (One, \_SB.PCI0.LPC0.EC0.LPBF)
        }
        Else
        {
            Store (Zero, \_SB.PCI0.LPC0.EC0.LPBF)
        }

        Return (BUFF) /* \PAFF.BUFF */
    }

    Method (GFRS, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        CreateByteField (BUFF, One, RELT)
        Store (Zero, STAT) /* \GFRS.STAT */
        Store (0x02, RELT) /* \GFRS.RELT */
        If (LEqual (\_SB.PCI0.LPC0.EC0.FNIS, Zero))
        {
            Store (One, RELT) /* \GFRS.RELT */
        }

        Return (BUFF) /* \GFRS.BUFF */
    }

    Method (SFRS, 1, Serialized)
    {
        Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
        Name (BUFF, Buffer (0x0100) {})
        Name (RELT, Zero)
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        CreateByteField (Arg0, 0x02, SFNM)
        Store (Zero, STAT) /* \SFRS.STAT */
        While (One)
        {
            Store (ToInteger (SFNM), _T_0) /* \SFRS._T_0 */
            If (LEqual (_T_0, One))
            {
                Store (Zero, RELT) /* \SFRS.RELT */
                Store (RELT, \_SB.PCI0.LPC0.EC0.FNIS)
            }
            Else
            {
                If (LEqual (_T_0, 0x02))
                {
                    Store (One, RELT) /* \SFRS.RELT */
                    Store (RELT, \_SB.PCI0.LPC0.EC0.FNIS)
                }
                Else
                {
                    Store (One, STAT) /* \SFRS.STAT */
                }
            }

            Break
        }

        WRCM (0x61, RELT)
        Return (BUFF) /* \SFRS.BUFF */
    }

    Method (SPDT, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (Arg0, 0x02, SPDT)
        CreateByteField (BUFF, Zero, STAT)
        Store (Zero, STAT) /* \SPDT.STAT */
        Store (\_SB.PCI0.LPC0.EC0.SPDT, SPDT) /* \SPDT.SPDT */
        Return (BUFF) /* \SPDT.BUFF */
    }

    Method (RPDT, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        CreateByteField (BUFF, One, GPDT)
        Store (Zero, STAT) /* \RPDT.STAT */
        Store (\_SB.PCI0.LPC0.EC0.SPDT, GPDT) /* \RPDT.GPDT */
        Return (BUFF) /* \RPDT.BUFF */
    }

    Method (RPPT, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        CreateByteField (BUFF, One, RPPT)
        Store (Zero, STAT) /* \RPPT.STAT */
        Store (\_SB.PCI0.LPC0.EC0.GPPT, RPPT) /* \RPPT.RPPT */
        Store (Zero, \_SB.PCI0.LPC0.EC0.GPPT)
        Return (BUFF) /* \RPPT.BUFF */
    }

    Method (SMLS, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        CreateByteField (BUFF, Zero, STAT)
        CreateByteField (Arg0, 0x02, SMLR)
        Store (Zero, STAT) /* \SMLS.STAT */
        If (LEqual (SMLR, One))
        {
            Store (One, \_SB.PCI0.LPC0.EC0.MICL)
        }
        Else
        {
            Store (Zero, \_SB.PCI0.LPC0.EC0.MICL)
        }

        Return (BUFF) /* \SMLS.BUFF */
    }

    Method (GSTP, 1, Serialized)
    {
        Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (Arg0, 0x02, GSII)
        CreateByteField (BUFF, Zero, STAT)
        CreateByteField (BUFF, One, GSIS)
        Store (Zero, STAT) /* \GSTP.STAT */
        Store (Local0, DAIN) /* External reference */
        Store (DAOU, BUFF) /* \GSTP.BUFF */
        While (One)
        {
            Store (ToInteger (GSII), _T_0) /* \GSTP._T_0 */
            If (LEqual (_T_0, Zero))
            {
                Store (SEBO, GSIS) /* \GSTP.GSIS */
            }
            Else
            {
                If (LEqual (_T_0, 0x10))
                {
                    Store (TPCM, GSIS) /* \GSTP.GSIS */
                }
                Else
                {
                    If (LEqual (_T_0, 0x21))
                    {
                        Store (HDEN, GSIS) /* \GSTP.GSIS */
                    }
                    Else
                    {
                        If (LEqual (_T_0, 0x22))
                        {
                            Store (PDEN, GSIS) /* \GSTP.GSIS */
                        }
                        Else
                        {
                            If (LEqual (_T_0, 0x23))
                            {
                                Store (CAEN, GSIS) /* \GSTP.GSIS */
                            }
                            Else
                            {
                                If (LEqual (_T_0, 0x24))
                                {
                                    Store (AUEN, GSIS) /* \GSTP.GSIS */
                                }
                                Else
                                {
                                    If (LEqual (_T_0, 0x25))
                                    {
                                        Store (WFEN, GSIS) /* \GSTP.GSIS */
                                    }
                                    Else
                                    {
                                        If (LEqual (_T_0, 0x26))
                                        {
                                            Store (BTEN, GSIS) /* \GSTP.GSIS */
                                        }
                                        Else
                                        {
                                            If (LEqual (_T_0, 0x30))
                                            {
                                                Store (KSVA, GSIS) /* \GSTP.GSIS */
                                            }
                                            Else
                                            {
                                                If (LEqual (_T_0, 0x40))
                                                {
                                                    Store (OWUS, GSIS) /* \GSTP.GSIS */
                                                }
                                                Else
                                                {
                                                    Store (One, STAT) /* \GSTP.STAT */
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Break
        }

        Return (BUFF) /* \GSTP.BUFF */
    }

    Method (SSTP, 1, Serialized)
    {
        Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (Arg0, 0x02, SSII)
        CreateByteField (Arg0, 0x03, SSIS)
        CreateByteField (BUFF, Zero, STAT)
        Store (Zero, STAT) /* \SSTP.STAT */
        Store (Local0, DAIN) /* External reference */
        Store (DAOU, BUFF) /* \SSTP.BUFF */
        While (One)
        {
            Store (ToInteger (SSII), _T_0) /* \SSTP._T_0 */
            If (LEqual (_T_0, Zero))
            {
                If (SSIS)
                {
                    Store (One, SEBO) /* External reference */
                }
                Else
                {
                    Store (Zero, SEBO) /* External reference */
                }
            }
            Else
            {
                If (LEqual (_T_0, 0x10))
                {
                    If (SSIS)
                    {
                        Store (One, TPCM) /* External reference */
                    }
                    Else
                    {
                        Store (Zero, TPCM) /* External reference */
                    }
                }
                Else
                {
                    If (LEqual (_T_0, 0x21))
                    {
                        If (SSIS)
                        {
                            Store (One, HDEN) /* External reference */
                        }
                        Else
                        {
                            Store (Zero, HDEN) /* External reference */
                        }
                    }
                    Else
                    {
                        If (LEqual (_T_0, 0x22))
                        {
                            If (SSIS)
                            {
                                Store (One, PDEN) /* External reference */
                            }
                            Else
                            {
                                Store (Zero, PDEN) /* External reference */
                            }
                        }
                        Else
                        {
                            If (LEqual (_T_0, 0x23))
                            {
                                If (SSIS)
                                {
                                    Store (One, CAEN) /* External reference */
                                }
                                Else
                                {
                                    Store (Zero, CAEN) /* External reference */
                                }
                            }
                            Else
                            {
                                If (LEqual (_T_0, 0x24))
                                {
                                    If (SSIS)
                                    {
                                        Store (One, AUEN) /* External reference */
                                    }
                                    Else
                                    {
                                        Store (Zero, AUEN) /* External reference */
                                    }
                                }
                                Else
                                {
                                    If (LEqual (_T_0, 0x25))
                                    {
                                        If (SSIS)
                                        {
                                            Store (One, WFEN) /* External reference */
                                        }
                                        Else
                                        {
                                            Store (Zero, WFEN) /* External reference */
                                        }
                                    }
                                    Else
                                    {
                                        If (LEqual (_T_0, 0x26))
                                        {
                                            If (SSIS)
                                            {
                                                Store (One, BTEN) /* External reference */
                                            }
                                            Else
                                            {
                                                Store (Zero, BTEN) /* External reference */
                                            }
                                        }
                                        Else
                                        {
                                            If (LEqual (_T_0, 0x30))
                                            {
                                                If (SSIS)
                                                {
                                                    Store (One, KSVA) /* External reference */
                                                }
                                                Else
                                                {
                                                    Store (Zero, KSVA) /* External reference */
                                                }
                                            }
                                            Else
                                            {
                                                If (LEqual (_T_0, 0x40))
                                                {
                                                    If (SSIS)
                                                    {
                                                        Store (One, OWUS) /* External reference */
                                                    }
                                                    Else
                                                    {
                                                        Store (Zero, OWUS) /* External reference */
                                                    }
                                                }
                                                Else
                                                {
                                                    Store (One, STAT) /* \SSTP.STAT */
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Break
        }

        HSMI ()
        Return (BUFF) /* \SSTP.BUFF */
    }

    Method (SLGO, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        Store (Zero, STAT) /* \SLGO.STAT */
        Store (Local0, DAIN) /* External reference */
        HSMI ()
        Store (DAOU, BUFF) /* \SLGO.BUFF */
        Return (BUFF) /* \SLGO.BUFF */
    }

    Method (GLGO, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100) {})
        Store (Arg0, Local0)
        CreateByteField (BUFF, Zero, STAT)
        Store (Zero, STAT) /* \GLGO.STAT */
        Store (Local0, DAIN) /* External reference */
        HSMI ()
        Store (DAOU, BUFF) /* \GLGO.BUFF */
        Return (BUFF) /* \GLGO.BUFF */
    }

    OperationRegion (DBG0, SystemIO, 0x80, One)
    Field (DBG0, ByteAcc, NoLock, Preserve)
    {
        IO80,   8
    }

    OperationRegion (DBG1, SystemIO, 0x80, 0x02)
    Field (DBG1, WordAcc, NoLock, Preserve)
    {
        P80H,   16
    }

    OperationRegion (ACMS, SystemIO, 0x72, 0x02)
    Field (ACMS, ByteAcc, NoLock, Preserve)
    {
        ACMX,   8, 
        ACMA,   8
    }

    IndexField (ACMX, ACMA, ByteAcc, NoLock, Preserve)
    {
        Offset (0xB9), 
        IMEN,   8
    }

    OperationRegion (PSMI, SystemIO, 0xB0, 0x02)
    Field (PSMI, ByteAcc, NoLock, Preserve)
    {
        APMC,   8, 
        APMD,   8
    }

    OperationRegion (PMRG, SystemIO, 0x0CD6, 0x02)
    Field (PMRG, ByteAcc, NoLock, Preserve)
    {
        PMRI,   8, 
        PMRD,   8
    }

    IndexField (PMRI, PMRD, ByteAcc, NoLock, Preserve)
    {
            ,   6, 
        HPEN,   1, 
        Offset (0x60), 
        P1EB,   16, 
        Offset (0xF0), 
            ,   3, 
        RSTU,   1
    }

    OperationRegion (GSMM, SystemMemory, 0xFED80000, 0x1000)
    Field (GSMM, AnyAcc, NoLock, Preserve)
    {
        Offset (0x288), 
            ,   1, 
        CLPS,   1, 
        Offset (0x2B0), 
            ,   2, 
        SLPS,   2, 
        Offset (0x3BB), 
            ,   6, 
        PWDE,   1, 
        Offset (0x3E4), 
        BLNK,   2
    }

    OperationRegion (P1E0, SystemIO, P1EB, 0x04)
    Field (P1E0, ByteAcc, NoLock, Preserve)
    {
            ,   14, 
        PEWS,   1, 
        WSTA,   1, 
            ,   14, 
        PEWD,   1
    }

    OperationRegion (IOCC, SystemIO, 0x0400, 0x80)
    Field (IOCC, ByteAcc, NoLock, Preserve)
    {
        Offset (0x01), 
            ,   2, 
        RTCS,   1
    }

    Name (PRWP, Package (0x02)
    {
        Zero, 
        Zero
    })
    Method (GPRW, 2, NotSerialized)
    {
        Store (Arg0, Index (PRWP, Zero))
        Store (Arg1, Index (PRWP, One))
        If (LEqual (DAS3, Zero))
        {
            If (LLessEqual (Arg1, 0x03))
            {
                Store (Zero, Index (PRWP, One))
            }
        }

        Return (PRWP) /* \PRWP */
    }

    Method (SPTS, 1, NotSerialized)
    {
        If (LEqual (Arg0, 0x03))
        {
            Store (One, BLNK) /* \BLNK */
        }

        If (LOr (LEqual (Arg0, 0x04), LEqual (Arg0, 0x05)))
        {
            Store (Zero, BLNK) /* \BLNK */
        }

        If (LEqual (Arg0, 0x03))
        {
            Store (Zero, RSTU) /* \RSTU */
        }

        Store (One, CLPS) /* \CLPS */
        Store (One, SLPS) /* \SLPS */
        Store (PEWS, PEWS) /* \PEWS */
    }

    Method (SWAK, 1, NotSerialized)
    {
        Store (0x03, BLNK) /* \BLNK */
        If (LEqual (Arg0, 0x03))
        {
            Store (One, RSTU) /* \RSTU */
        }

        Store (PEWS, PEWS) /* \PEWS */
        Store (One, PWDE) /* \PWDE */
        Store (Zero, PEWD) /* \PEWD */
    }

    OperationRegion (GNVS, SystemMemory, 0x8F7BBA98, 0x0186)
    Field (GNVS, AnyAcc, NoLock, Preserve)
    {
        SMIF,   8, 
        PRM0,   8, 
        PRM1,   8, 
        BRTL,   8, 
        TLST,   8, 
        IGDS,   8, 
        LCDA,   16, 
        CSTE,   16, 
        NSTE,   16, 
        CADL,   16, 
        PADL,   16, 
        LIDS,   8, 
        PWRS,   8, 
        BVAL,   32, 
        ADDL,   16, 
        BCMD,   8, 
        SBFN,   8, 
        DID,    32, 
        INFO,   2048, 
        TOML,   8, 
        TOMH,   8, 
        CEBP,   8, 
        C0LS,   8, 
        C1LS,   8, 
        C0HS,   8, 
        C1HS,   8, 
        ROMS,   32, 
        MUXF,   8, 
        PDDN,   8, 
        CNSB,   8, 
        RDHW,   8, 
        DAS3,   8, 
        TNBH,   8, 
        TCP0,   8, 
        TCP1,   8, 
        ATNB,   8, 
        PCP0,   8, 
        PCP1,   8, 
        PWMN,   8, 
        LPTY,   8, 
        M92D,   8, 
        WKPM,   8, 
        ALST,   8, 
        AFUC,   8, 
        EXUS,   8, 
        GV0E,   8, 
        WLSH,   8, 
        TSSS,   8, 
        AOZP,   8, 
        TZFG,   8, 
        BPS0,   8, 
        NAPC,   8, 
        PCBA,   32, 
        PCBL,   32, 
        WLAN,   8, 
        BLTH,   8, 
        GPSS,   8, 
        NFCS,   8, 
        SBTY,   8, 
        BDID,   16, 
        MWTT,   8, 
        ACPM,   8, 
        KBCS,   8, 
        ACEC,   8, 
        MM64,   8, 
        HMB1,   64, 
        HMB2,   64, 
        HMM1,   64, 
        HMM2,   64, 
        HML1,   64, 
        HML2,   64
    }

    OperationRegion (OGNS, SystemMemory, 0x8F7A0E98, 0x0B)
    Field (OGNS, AnyAcc, Lock, Preserve)
    {
        EGPO,   8, 
        BTBE,   8, 
        M2WL,   8, 
        THPN,   8, 
        PBAR,   8, 
        THPD,   8, 
        FNPR,   8, 
        OG07,   8, 
        OG08,   8, 
        OG09,   8, 
        OG10,   8
    }

    Method (SCMP, 2, NotSerialized)
    {
        Name (STG1, Buffer (0x50) {})
        Name (STG2, Buffer (0x50) {})
        Store (Arg0, STG1) /* \SCMP.STG1 */
        Store (Arg1, STG2) /* \SCMP.STG2 */
        If (LNotEqual (SizeOf (Arg0), SizeOf (Arg1)))
        {
            Return (Zero)
        }

        Store (Zero, Local0)
        While (LLess (Local0, SizeOf (Arg0)))
        {
            If (LNotEqual (DerefOf (Index (STG1, Local0)), DerefOf (Index (
                STG2, Local0))))
            {
                Return (Zero)
            }

            Increment (Local0)
        }

        Return (One)
    }

    Name (WNOS, Zero)
    Name (MYOS, Zero)
    Name (HTTS, Zero)
    Name (OSTB, Ones)
    Name (TPOS, Zero)
    Name (LINX, Zero)
    Name (OSSP, Zero)
    Method (SEQL, 2, Serialized)
    {
        Store (SizeOf (Arg0), Local0)
        Store (SizeOf (Arg1), Local1)
        If (LNotEqual (Local0, Local1))
        {
            Return (Zero)
        }

        Name (BUF0, Buffer (Local0) {})
        Store (Arg0, BUF0) /* \SEQL.BUF0 */
        Name (BUF1, Buffer (Local0) {})
        Store (Arg1, BUF1) /* \SEQL.BUF1 */
        Store (Zero, Local2)
        While (LLess (Local2, Local0))
        {
            Store (DerefOf (Index (BUF0, Local2)), Local3)
            Store (DerefOf (Index (BUF1, Local2)), Local4)
            If (LNotEqual (Local3, Local4))
            {
                Return (Zero)
            }

            Increment (Local2)
        }

        Return (One)
    }

    Method (OSTP, 0, NotSerialized)
    {
        If (LEqual (OSTB, Ones))
        {
            If (CondRefOf (\_OSI, Local0))
            {
                Store (Zero, OSTB) /* \OSTB */
                Store (Zero, TPOS) /* \TPOS */
                If (_OSI ("Windows 2001"))
                {
                    Store (0x08, OSTB) /* \OSTB */
                    Store (0x08, TPOS) /* \TPOS */
                }

                If (_OSI ("Windows 2001.1"))
                {
                    Store (0x20, OSTB) /* \OSTB */
                    Store (0x20, TPOS) /* \TPOS */
                }

                If (_OSI ("Windows 2001 SP1"))
                {
                    Store (0x10, OSTB) /* \OSTB */
                    Store (0x10, TPOS) /* \TPOS */
                }

                If (_OSI ("Windows 2001 SP2"))
                {
                    Store (0x11, OSTB) /* \OSTB */
                    Store (0x11, TPOS) /* \TPOS */
                }

                If (_OSI ("Windows 2001 SP3"))
                {
                    Store (0x12, OSTB) /* \OSTB */
                    Store (0x12, TPOS) /* \TPOS */
                }

                If (_OSI ("Windows 2006"))
                {
                    Store (0x40, OSTB) /* \OSTB */
                    Store (0x40, TPOS) /* \TPOS */
                }

                If (_OSI ("Windows 2006 SP1"))
                {
                    Store (0x41, OSTB) /* \OSTB */
                    Store (0x41, TPOS) /* \TPOS */
                    Store (One, OSSP) /* \OSSP */
                }

                If (_OSI ("Windows 2009"))
                {
                    Store (One, OSSP) /* \OSSP */
                    Store (0x50, OSTB) /* \OSTB */
                    Store (0x50, TPOS) /* \TPOS */
                }

                If (_OSI ("Windows 2012"))
                {
                    Store (One, OSSP) /* \OSSP */
                    Store (0x60, OSTB) /* \OSTB */
                    Store (0x60, TPOS) /* \TPOS */
                }

                If (_OSI ("Windows 2013"))
                {
                    Store (One, OSSP) /* \OSSP */
                    Store (0x61, OSTB) /* \OSTB */
                    Store (0x61, TPOS) /* \TPOS */
                }

                If (_OSI ("Windows 2015"))
                {
                    Store (One, OSSP) /* \OSSP */
                    Store (0x70, OSTB) /* \OSTB */
                    Store (0x70, TPOS) /* \TPOS */
                }

                If (_OSI ("Linux"))
                {
                    Store (One, LINX) /* \LINX */
                    Store (0x80, OSTB) /* \OSTB */
                    Store (0x80, TPOS) /* \TPOS */
                }
            }
            Else
            {
                If (CondRefOf (\_OS, Local0))
                {
                    If (SEQL (_OS, "Microsoft Windows"))
                    {
                        Store (One, OSTB) /* \OSTB */
                        Store (One, TPOS) /* \TPOS */
                    }
                    Else
                    {
                        If (SEQL (_OS, "Microsoft WindowsME: Millennium Edition"))
                        {
                            Store (0x02, OSTB) /* \OSTB */
                            Store (0x02, TPOS) /* \TPOS */
                        }
                        Else
                        {
                            If (SEQL (_OS, "Microsoft Windows NT"))
                            {
                                Store (0x04, OSTB) /* \OSTB */
                                Store (0x04, TPOS) /* \TPOS */
                            }
                            Else
                            {
                                Store (Zero, OSTB) /* \OSTB */
                                Store (Zero, TPOS) /* \TPOS */
                            }
                        }
                    }
                }
                Else
                {
                    Store (Zero, OSTB) /* \OSTB */
                    Store (Zero, TPOS) /* \TPOS */
                }
            }
        }

        Return (OSTB) /* \OSTB */
    }

    Name (BUFN, Zero)
    Name (MBUF, Buffer (0x1000) {})
    OperationRegion (MDBG, SystemMemory, 0x8F399018, 0x1004)
    Field (MDBG, AnyAcc, Lock, Preserve)
    {
        MDG0,   32768
    }

    Method (DB2H, 1, Serialized)
    {
        SHOW (Arg0)
        MDGC (0x20)
        Store (MBUF, MDG0) /* \MDG0 */
    }

    Method (DW2H, 1, Serialized)
    {
        Store (Arg0, Local0)
        ShiftRight (Arg0, 0x08, Local1)
        And (Local0, 0xFF, Local0)
        And (Local1, 0xFF, Local1)
        DB2H (Local1)
        Decrement (BUFN)
        DB2H (Local0)
    }

    Method (DD2H, 1, Serialized)
    {
        Store (Arg0, Local0)
        ShiftRight (Arg0, 0x10, Local1)
        And (Local0, 0xFFFF, Local0)
        And (Local1, 0xFFFF, Local1)
        DW2H (Local1)
        Decrement (BUFN)
        DW2H (Local0)
    }

    Method (MBGS, 1, Serialized)
    {
        Store (SizeOf (Arg0), Local0)
        Name (BUFS, Buffer (Local0) {})
        Store (Arg0, BUFS) /* \MBGS.BUFS */
        MDGC (0x20)
        While (Local0)
        {
            MDGC (DerefOf (Index (BUFS, Subtract (SizeOf (Arg0), Local0))))
            Decrement (Local0)
        }

        Store (MBUF, MDG0) /* \MDG0 */
    }

    Method (SHOW, 1, Serialized)
    {
        MDGC (NTOC (ShiftRight (Arg0, 0x04)))
        MDGC (NTOC (Arg0))
    }

    Method (LINE, 0, Serialized)
    {
        Store (BUFN, Local0)
        And (Local0, 0x0F, Local0)
        While (Local0)
        {
            MDGC (Zero)
            Increment (Local0)
            And (Local0, 0x0F, Local0)
        }
    }

    Method (MDGC, 1, Serialized)
    {
        Store (Arg0, Index (MBUF, BUFN))
        Add (BUFN, One, BUFN) /* \BUFN */
        If (LGreater (BUFN, 0x0FFF))
        {
            And (BUFN, 0x0FFF, BUFN) /* \BUFN */
            UP_L (One)
        }
    }

    Method (UP_L, 1, Serialized)
    {
        Store (Arg0, Local2)
        ShiftLeft (Local2, 0x04, Local2)
        MOVE (Local2)
        Subtract (0x1000, Local2, Local3)
        While (Local2)
        {
            Store (Zero, Index (MBUF, Local3))
            Increment (Local3)
            Decrement (Local2)
        }
    }

    Method (MOVE, 1, Serialized)
    {
        Store (Arg0, Local4)
        Store (Zero, BUFN) /* \BUFN */
        Subtract (0x1000, Local4, Local5)
        While (Local5)
        {
            Decrement (Local5)
            Store (DerefOf (Index (MBUF, Local4)), Index (MBUF, BUFN))
            Increment (BUFN)
            Increment (Local4)
        }
    }

    Method (NTOC, 1, Serialized)
    {
        And (Arg0, 0x0F, Local0)
        If (LLess (Local0, 0x0A))
        {
            Add (Local0, 0x30, Local0)
        }
        Else
        {
            Add (Local0, 0x37, Local0)
        }

        Return (Local0)
    }

    Scope (_PR)
    {
        Processor (C000, 0x00, 0x00000410, 0x06) {}
        Processor (C001, 0x01, 0x00000410, 0x06) {}
        Processor (C002, 0x02, 0x00000410, 0x06) {}
        Processor (C003, 0x03, 0x00000410, 0x06) {}
        Processor (C004, 0x04, 0x00000410, 0x06) {}
        Processor (C005, 0x05, 0x00000410, 0x06) {}
        Processor (C006, 0x06, 0x00000410, 0x06) {}
        Processor (C007, 0x07, 0x00000410, 0x06) {}
    }

    Name (_S0, Package (0x04)  // _S0_: S0 System State
    {
        Zero, 
        Zero, 
        Zero, 
        Zero
    })
    If (LEqual (DAS3, One))
    {
        Name (_S3, Package (0x04)  // _S3_: S3 System State
        {
            0x03, 
            0x03, 
            Zero, 
            Zero
        })
    }

    Name (_S4, Package (0x04)  // _S4_: S4 System State
    {
        0x04, 
        0x04, 
        Zero, 
        Zero
    })
    Name (_S5, Package (0x04)  // _S5_: S5 System State
    {
        0x05, 
        0x05, 
        Zero, 
        Zero
    })
    Scope (_GPE)
    {
        Method (_L08, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
            Notify (\_SB.PCI0.GPP0, 0x02) // Device Wake
            Notify (\_SB.PCI0.GPP1, 0x02) // Device Wake
            Notify (\_SB.PCI0.GPP2, 0x02) // Device Wake
            Notify (\_SB.PCI0.GPP3, 0x02) // Device Wake
            Notify (\_SB.PCI0.GPP4, 0x02) // Device Wake
            Notify (\_SB.PCI0.GPP5, 0x02) // Device Wake
            Notify (\_SB.PCI0.GPP6, 0x02) // Device Wake
            Notify (\_SB.PCI0.GP17, 0x02) // Device Wake
            Notify (\_SB.PCI0.GP18, 0x02) // Device Wake
        }

        Method (_L19, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
            Notify (\_SB.PCI0.GP17.XHC0, 0x02) // Device Wake
            Notify (\_SB.PCI0.GP17.XHC1, 0x02) // Device Wake
        }
    }

    Name (PICM, Zero)
    Name (GPIC, Zero)
    Method (_PIC, 1, NotSerialized)  // _PIC: Interrupt Model
    {
        Store (Arg0, PICM) /* \PICM */
        Store (Arg0, GPIC) /* \GPIC */
        If (PICM)
        {
            \_SB.DSPI ()
            If (NAPC)
            {
                \_SB.PCI0.NAPE ()
            }
        }
    }

    Method (WRCM, 2, Serialized)
    {
        OperationRegion (CMOS, SystemIO, 0x70, 0x04)
        Field (CMOS, AnyAcc, NoLock, Preserve)
        {
            LIND,   8, 
            LDAT,   8, 
            HIND,   8, 
            HDAT,   8
        }

        Store (Arg0, HIND) /* \WRCM.HIND */
        Store (Arg1, HDAT) /* \WRCM.HDAT */
    }

    Method (_PTS, 1, NotSerialized)  // _PTS: Prepare To Sleep
    {
        If (LEqual (Arg0, 0x05)) {}
        Else
        {
            \_SB.PCI0.LPC0.EC0.ECMD (0x9B)
            WRCM (0x67, One)
            If (LEqual (Arg0, One))
            {
                \_SB.S80H (0x51)
            }

            If (LEqual (Arg0, 0x03))
            {
                \_SB.S80H (0x53)
                WRCM (0x04, \_SB.PCI0.LPC0.EC0.KCMS)
                Store (One, SLPS) /* \SLPS */
            }

            If (LEqual (Arg0, 0x04))
            {
                \_SB.S80H (0x54)
                WRCM (0x04, \_SB.PCI0.LPC0.EC0.KCMS)
                Store (One, SLPS) /* \SLPS */
                Store (One, RSTU) /* \RSTU */
            }

            If (LEqual (Arg0, 0x05))
            {
                \_SB.S80H (0x55)
                WRCM (0x04, \_SB.PCI0.LPC0.EC0.KCMS)
                Store (0x90, BCMD) /* \BCMD */
                \_SB.BSMI (Zero)
                \_SB.GSMI (0x03)
            }

            If (CondRefOf (\_SB.TPM2.PTS))
            {
                \_SB.TPM2.PTS (Arg0)
            }

            \_SB.APTS (Arg0, MPTS (Arg0))
        }
    }

    Method (_WAK, 1, NotSerialized)  // _WAK: Wake
    {
        If (LOr (LLess (Arg0, One), LGreater (Arg0, 0x05)))
        {
            Store (0x03, Arg0)
        }

        Store (Zero, \_SB.PCI0.LPC0.EC0.BPWC)
        Store (Zero, \_SB.PCI0.LPC0.EC0.BPWR)
        \_SB.AWAK (Arg0)
        If (LOr (LEqual (Arg0, 0x03), LEqual (Arg0, 0x04)))
        {
            If (LNotEqual (GPIC, Zero))
            {
                \_SB.DSPI ()
                If (NAPC)
                {
                    \_SB.PCI0.NAPE ()
                }
            }

            \_SB.PCI0.LPC0.EC0.SELE ()
            \_SB.PCI0.LPC0.EC0.CHKB ()
            Store (0x02, \_SB.PCI0.LPC0.EC0.CPSM)
            \_SB.PCI0.LPC0.EC0.CTDP ()
        }

        If (LEqual (Arg0, 0x03))
        {
            \_SB.S80H (0xE3)
            Notify (\_SB.PWRB, 0x02) // Device Wake
        }

        If (LEqual (Arg0, 0x04))
        {
            \_SB.S80H (0xE4)
            Notify (\_SB.PWRB, 0x02) // Device Wake
        }

        If (LEqual (Arg0, 0x03))
        {
            Notify (\_SB.PWRB, 0x02) // Device Wake
        }

        Store (Zero, \_SB.PCI0.LPC0.EC0.ERRL)
        MWAK (Arg0)
        Return (Zero)
    }

    Scope (_SB)
    {
        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C") /* Power Button Device */)  // _HID: Hardware ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0B)
            }
        }

        Device (PCI0)
        {
            Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
            Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_BBN, Zero)  // _BBN: BIOS Bus Number
            Name (_ADR, Zero)  // _ADR: Address
            Method (_INI, 0, NotSerialized)  // _INI: Initialize
            {
                If (LNotEqual (GPIC, Zero))
                {
                    DSPI ()
                    If (\NAPC)
                    {
                        NAPE ()
                    }
                }

                OSTP ()
            }

            Name (SUPP, Zero)
            Name (CTRL, Zero)
            Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
            {
                CreateDWordField (Arg3, Zero, CDW1)
                CreateDWordField (Arg3, 0x04, CDW2)
                CreateDWordField (Arg3, 0x08, CDW3)
                If (LEqual (Arg0, ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */))
                {
                    Store (CDW2, SUPP) /* \_SB_.PCI0.SUPP */
                    Store (CDW3, CTRL) /* \_SB_.PCI0.CTRL */
                    If (LNotEqual (And (SUPP, 0x16), 0x16))
                    {
                        And (CTRL, 0x1E, CTRL) /* \_SB_.PCI0.CTRL */
                    }

                    And (CTRL, 0x1D, CTRL) /* \_SB_.PCI0.CTRL */
                    If (Not (And (CDW1, One)))
                    {
                        If (And (CTRL, One)) {}
                        If (And (CTRL, 0x04)) {}
                        If (And (CTRL, 0x10)) {}
                    }

                    If (LNotEqual (Arg1, One))
                    {
                        Or (CDW1, 0x08, CDW1) /* \_SB_.PCI0._OSC.CDW1 */
                    }

                    If (LNotEqual (CDW3, CTRL))
                    {
                        Or (CDW1, 0x10, CDW1) /* \_SB_.PCI0._OSC.CDW1 */
                    }

                    Store (CTRL, CDW3) /* \_SB_.PCI0._OSC.CDW3 */
                    Return (Arg3)
                }
                Else
                {
                    Or (CDW1, 0x04, CDW1) /* \_SB_.PCI0._OSC.CDW1 */
                    Return (Arg3)
                }
            }

            Method (TOM, 0, NotSerialized)
            {
                Multiply (TOML, 0x00010000, Local0)
                Multiply (TOMH, 0x01000000, Local1)
                Add (Local0, Local1, Local0)
                Return (Local0)
            }

            Name (CRES, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, SubDecode,
                    0x0000,             // Granularity
                    0x0000,             // Range Minimum
                    0x00FF,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0100,             // Length
                    0x00,, )
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,             // Granularity
                    0x0000,             // Range Minimum
                    0x0CF7,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0CF8,             // Length
                    0x00,, , TypeStatic)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,             // Granularity
                    0x0D00,             // Range Minimum
                    0xFFFF,             // Range Maximum
                    0x0000,             // Translation Offset
                    0xF300,             // Length
                    ,, , TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000A0000,         // Range Minimum
                    0x000BFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00020000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, Cacheable, ReadOnly,
                    0x00000000,         // Granularity
                    0x000C0000,         // Range Minimum
                    0x000C3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, Cacheable, ReadOnly,
                    0x00000000,         // Granularity
                    0x000C4000,         // Range Minimum
                    0x000C7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadOnly,
                    0x00000000,         // Granularity
                    0x000C8000,         // Range Minimum
                    0x000CBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadOnly,
                    0x00000000,         // Granularity
                    0x000CC000,         // Range Minimum
                    0x000CFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D0000,         // Range Minimum
                    0x000D3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D4000,         // Range Minimum
                    0x000D7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D8000,         // Range Minimum
                    0x000DBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000DC000,         // Range Minimum
                    0x000DFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E0000,         // Range Minimum
                    0x000E3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E4000,         // Range Minimum
                    0x000E7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E8000,         // Range Minimum
                    0x000EBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000EC000,         // Range Minimum
                    0x000EFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x80000000,         // Range Minimum
                    0xF7FFFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x78000000,         // Length
                    0x00,, _Y00, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0xFC000000,         // Range Minimum
                    0xFED3FFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x02D40000,         // Length
                    0x00,, _Y01, AddressRangeMemory, TypeStatic)
                IO (Decode16,
                    0x0CF8,             // Range Minimum
                    0x0CF8,             // Range Maximum
                    0x01,               // Alignment
                    0x08,               // Length
                    )
                QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x0000000000000000, // Granularity
                    0x0000000000000000, // Range Minimum
                    0x0000000000000000, // Range Maximum
                    0x0000000000000000, // Translation Offset
                    0x0000000000000000, // Length
                    ,, _Y02, AddressRangeMemory, TypeStatic)
                QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x0000000000000000, // Granularity
                    0x0000000000000000, // Range Minimum
                    0x0000000000000000, // Range Maximum
                    0x0000000000000000, // Translation Offset
                    0x0000000000000000, // Length
                    ,, _Y03, AddressRangeMemory, TypeStatic)
            })
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateDWordField (CRES, \_SB.PCI0._Y00._MIN, BTMN)  // _MIN: Minimum Base Address
                CreateDWordField (CRES, \_SB.PCI0._Y00._MAX, BTMX)  // _MAX: Maximum Base Address
                CreateDWordField (CRES, \_SB.PCI0._Y00._LEN, BTLN)  // _LEN: Length
                CreateDWordField (CRES, \_SB.PCI0._Y01._MIN, BTN1)  // _MIN: Minimum Base Address
                CreateDWordField (CRES, \_SB.PCI0._Y01._MAX, BTX1)  // _MAX: Maximum Base Address
                CreateDWordField (CRES, \_SB.PCI0._Y01._LEN, BTL1)  // _LEN: Length
                Store (TOM (), BTMN) /* \_SB_.PCI0._CRS.BTMN */
                Subtract (PCBA, One, BTMX) /* \_SB_.PCI0._CRS.BTMX */
                Subtract (PCBA, BTMN, BTLN) /* \_SB_.PCI0._CRS.BTLN */
                Add (PCBL, One, BTN1) /* \_SB_.PCI0._CRS.BTN1 */
                Subtract (BTX1, BTN1, BTL1) /* \_SB_.PCI0._CRS.BTL1 */
                Add (BTL1, One, BTL1) /* \_SB_.PCI0._CRS.BTL1 */
                If (LEqual (MM64, One))
                {
                    CreateQWordField (CRES, \_SB.PCI0._Y02._MIN, M1MN)  // _MIN: Minimum Base Address
                    CreateQWordField (CRES, \_SB.PCI0._Y02._MAX, M1MX)  // _MAX: Maximum Base Address
                    CreateQWordField (CRES, \_SB.PCI0._Y02._LEN, M1LN)  // _LEN: Length
                    Store (HMB1, M1MN) /* \_SB_.PCI0._CRS.M1MN */
                    Store (HMM1, M1MX) /* \_SB_.PCI0._CRS.M1MX */
                    Store (HML1, M1LN) /* \_SB_.PCI0._CRS.M1LN */
                    CreateQWordField (CRES, \_SB.PCI0._Y03._MIN, M2MN)  // _MIN: Minimum Base Address
                    CreateQWordField (CRES, \_SB.PCI0._Y03._MAX, M2MX)  // _MAX: Maximum Base Address
                    CreateQWordField (CRES, \_SB.PCI0._Y03._LEN, M2LN)  // _LEN: Length
                    Store (HMB2, M2MN) /* \_SB_.PCI0._CRS.M2MN */
                    Store (HMM2, M2MX) /* \_SB_.PCI0._CRS.M2MX */
                    Store (HML2, M2LN) /* \_SB_.PCI0._CRS.M2LN */
                }

                Return (CRES) /* \_SB_.PCI0.CRES */
            }

            Device (MEMR)
            {
                Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                Name (BAR3, 0xFDA00000)
                Name (MEM1, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00000000,         // Address Length
                        _Y04)
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00000000,         // Address Length
                        _Y05)
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00000000,         // Address Length
                        _Y06)
                })
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    CreateDWordField (MEM1, \_SB.PCI0.MEMR._Y04._BAS, MB01)  // _BAS: Base Address
                    CreateDWordField (MEM1, \_SB.PCI0.MEMR._Y04._LEN, ML01)  // _LEN: Length
                    CreateDWordField (MEM1, \_SB.PCI0.MEMR._Y05._BAS, MB02)  // _BAS: Base Address
                    CreateDWordField (MEM1, \_SB.PCI0.MEMR._Y05._LEN, ML02)  // _LEN: Length
                    CreateDWordField (MEM1, \_SB.PCI0.MEMR._Y06._BAS, MB03)  // _BAS: Base Address
                    CreateDWordField (MEM1, \_SB.PCI0.MEMR._Y06._LEN, ML03)  // _LEN: Length
                    If (GPIC)
                    {
                        Store (0xFEC00000, MB01) /* \_SB_.PCI0.MEMR._CRS.MB01 */
                        Store (0xFEE00000, MB02) /* \_SB_.PCI0.MEMR._CRS.MB02 */
                        Store (0x1000, ML01) /* \_SB_.PCI0.MEMR._CRS.ML01 */
                        If (\NAPC)
                        {
                            Add (ML01, 0x1000, ML01) /* \_SB_.PCI0.MEMR._CRS.ML01 */
                        }

                        Store (0x1000, ML02) /* \_SB_.PCI0.MEMR._CRS.ML02 */
                    }

                    If (LNotEqual (BAR3, 0xFFF00000))
                    {
                        Store (BAR3, MB03) /* \_SB_.PCI0.MEMR._CRS.MB03 */
                        Store (0x00100000, ML03) /* \_SB_.PCI0.MEMR._CRS.ML03 */
                    }

                    Return (MEM1) /* \_SB_.PCI0.MEMR.MEM1 */
                }
            }

            OperationRegion (NAPC, PCI_Config, 0xB8, 0x08)
            Field (NAPC, DWordAcc, NoLock, Preserve)
            {
                NAPX,   32, 
                NAPD,   32
            }

            Mutex (NAPM, 0x00)
            Method (NAPE, 0, NotSerialized)
            {
                Acquire (NAPM, 0xFFFF)
                Store (0x14300000, NAPX) /* \_SB_.PCI0.NAPX */
                Store (NAPD, Local0)
                And (Local0, 0xFFFFFFEF, Local0)
                Store (Local0, NAPD) /* \_SB_.PCI0.NAPD */
                Release (NAPM)
            }

            Name (PR00, Package (0x0A)
            {
                Package (0x04)
                {
                    0x0001FFFF, 
                    Zero, 
                    LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    One, 
                    LNKB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    0x02, 
                    LNKC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    0x03, 
                    LNKD, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0008FFFF, 
                    Zero, 
                    LNKD, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0008FFFF, 
                    One, 
                    LNKE, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    Zero, 
                    LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    One, 
                    LNKB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    0x02, 
                    LNKC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    0x03, 
                    LNKD, 
                    Zero
                }
            })
            Name (AR00, Package (0x0A)
            {
                Package (0x04)
                {
                    0x0001FFFF, 
                    Zero, 
                    Zero, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    One, 
                    Zero, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    0x02, 
                    Zero, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    0x03, 
                    Zero, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x0008FFFF, 
                    Zero, 
                    Zero, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x0008FFFF, 
                    One, 
                    Zero, 
                    0x14
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    Zero, 
                    Zero, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    One, 
                    Zero, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    0x02, 
                    Zero, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    0x03, 
                    Zero, 
                    0x13
                }
            })
            Name (NR00, Package (0x0A)
            {
                Package (0x04)
                {
                    0x0001FFFF, 
                    Zero, 
                    Zero, 
                    0x28
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    One, 
                    Zero, 
                    0x29
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    0x02, 
                    Zero, 
                    0x2A
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    0x03, 
                    Zero, 
                    0x2B
                }, 

                Package (0x04)
                {
                    0x0008FFFF, 
                    Zero, 
                    Zero, 
                    0x2B
                }, 

                Package (0x04)
                {
                    0x0008FFFF, 
                    One, 
                    Zero, 
                    0x24
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    Zero, 
                    Zero, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    One, 
                    Zero, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    0x02, 
                    Zero, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    0x03, 
                    Zero, 
                    0x13
                }
            })
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    If (\NAPC)
                    {
                        Return (NR00) /* \_SB_.PCI0.NR00 */
                    }
                    Else
                    {
                        Return (AR00) /* \_SB_.PCI0.AR00 */
                    }
                }
                Else
                {
                    Return (PR00) /* \_SB_.PCI0.PR00 */
                }
            }

            Device (GPP0)
            {
                Name (_ADR, 0x00010001)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    If (LEqual (WKPM, One))
                    {
                        Return (GPRW (0x08, 0x04))
                    }
                    Else
                    {
                        Return (GPRW (0x08, Zero))
                    }
                }

                Name (PR01, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        LNKA, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        LNKB, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKC, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKD, 
                        Zero
                    }
                })
                Name (AR01, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x13
                    }
                })
                Name (NR01, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x18
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x19
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x1A
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x1B
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        If (\NAPC)
                        {
                            Return (NR01) /* \_SB_.PCI0.GPP0.NR01 */
                        }
                        Else
                        {
                            Return (AR01) /* \_SB_.PCI0.GPP0.AR01 */
                        }
                    }
                    Else
                    {
                        Return (PR01) /* \_SB_.PCI0.GPP0.PR01 */
                    }
                }

                Device (VGA)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Name (DOSA, Zero)
                    Method (_DOS, 1, NotSerialized)  // _DOS: Disable Output Switching
                    {
                        Store (Arg0, DOSA) /* \_SB_.PCI0.GPP0.VGA_.DOSA */
                    }

                    Method (_DOD, 0, NotSerialized)  // _DOD: Display Output Devices
                    {
                        Return (Package (0x05)
                        {
                            0x00010110, 
                            0x00010210, 
                            0x00010220, 
                            0x00010230, 
                            0x00010240
                        })
                    }

                    Device (LCD)
                    {
                        Name (_ADR, 0x0110)  // _ADR: Address
                        Name (BCLB, Package (0x34)
                        {
                            0x5A, 
                            0x3C, 
                            0x02, 
                            0x04, 
                            0x06, 
                            0x08, 
                            0x0A, 
                            0x0C, 
                            0x0E, 
                            0x10, 
                            0x12, 
                            0x14, 
                            0x16, 
                            0x18, 
                            0x1A, 
                            0x1C, 
                            0x1E, 
                            0x20, 
                            0x22, 
                            0x24, 
                            0x26, 
                            0x28, 
                            0x2A, 
                            0x2C, 
                            0x2E, 
                            0x30, 
                            0x32, 
                            0x34, 
                            0x36, 
                            0x38, 
                            0x3A, 
                            0x3C, 
                            0x3E, 
                            0x40, 
                            0x42, 
                            0x44, 
                            0x46, 
                            0x48, 
                            0x4A, 
                            0x4C, 
                            0x4E, 
                            0x50, 
                            0x52, 
                            0x54, 
                            0x56, 
                            0x58, 
                            0x5A, 
                            0x5C, 
                            0x5E, 
                            0x60, 
                            0x62, 
                            0x64
                        })
                        Method (_BCL, 0, NotSerialized)  // _BCL: Brightness Control Levels
                        {
                            Return (BCLB) /* \_SB_.PCI0.GPP0.VGA_.LCD_.BCLB */
                        }

                        Method (_BCM, 1, NotSerialized)  // _BCM: Brightness Control Method
                        {
                            Divide (Multiply (Arg0, 0xFF), 0x64, Local1, Local0)
                            AFN7 (Local0)
                            Store (Arg0, BRTL) /* \BRTL */
                        }
                    }

                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                    {
                        Return (Zero)
                    }
                }

                Device (HDAU)
                {
                    Name (_ADR, One)  // _ADR: Address
                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                    {
                        Return (Zero)
                    }
                }
            }

            Device (GPP1)
            {
                Name (_ADR, 0x00010002)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    If (LEqual (WKPM, One))
                    {
                        Return (GPRW (0x08, 0x04))
                    }
                    Else
                    {
                        Return (GPRW (0x08, Zero))
                    }
                }

                Name (PR02, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        LNKE, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        LNKF, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKG, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKH, 
                        Zero
                    }
                })
                Name (AR02, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x14
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x15
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x16
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x17
                    }
                })
                Name (NR02, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x1C
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x1D
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x1E
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x1F
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        If (\NAPC)
                        {
                            Return (NR02) /* \_SB_.PCI0.GPP1.NR02 */
                        }
                        Else
                        {
                            Return (AR02) /* \_SB_.PCI0.GPP1.AR02 */
                        }
                    }
                    Else
                    {
                        Return (PR02) /* \_SB_.PCI0.GPP1.PR02 */
                    }
                }

                Device (VGA)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Name (DOSA, Zero)
                    Method (_DOS, 1, NotSerialized)  // _DOS: Disable Output Switching
                    {
                        Store (Arg0, DOSA) /* \_SB_.PCI0.GPP1.VGA_.DOSA */
                    }

                    Method (_DOD, 0, NotSerialized)  // _DOD: Display Output Devices
                    {
                        Return (Package (0x05)
                        {
                            0x00010110, 
                            0x00010210, 
                            0x00010220, 
                            0x00010230, 
                            0x00010240
                        })
                    }

                    Device (LCD)
                    {
                        Name (_ADR, 0x0110)  // _ADR: Address
                        Name (BCLB, Package (0x34)
                        {
                            0x5A, 
                            0x3C, 
                            0x02, 
                            0x04, 
                            0x06, 
                            0x08, 
                            0x0A, 
                            0x0C, 
                            0x0E, 
                            0x10, 
                            0x12, 
                            0x14, 
                            0x16, 
                            0x18, 
                            0x1A, 
                            0x1C, 
                            0x1E, 
                            0x20, 
                            0x22, 
                            0x24, 
                            0x26, 
                            0x28, 
                            0x2A, 
                            0x2C, 
                            0x2E, 
                            0x30, 
                            0x32, 
                            0x34, 
                            0x36, 
                            0x38, 
                            0x3A, 
                            0x3C, 
                            0x3E, 
                            0x40, 
                            0x42, 
                            0x44, 
                            0x46, 
                            0x48, 
                            0x4A, 
                            0x4C, 
                            0x4E, 
                            0x50, 
                            0x52, 
                            0x54, 
                            0x56, 
                            0x58, 
                            0x5A, 
                            0x5C, 
                            0x5E, 
                            0x60, 
                            0x62, 
                            0x64
                        })
                        Method (_BCL, 0, NotSerialized)  // _BCL: Brightness Control Levels
                        {
                            Return (BCLB) /* \_SB_.PCI0.GPP1.VGA_.LCD_.BCLB */
                        }

                        Method (_BCM, 1, NotSerialized)  // _BCM: Brightness Control Method
                        {
                            Divide (Multiply (Arg0, 0xFF), 0x64, Local1, Local0)
                            AFN7 (Local0)
                            Store (Arg0, BRTL) /* \BRTL */
                        }
                    }

                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                    {
                        Return (Zero)
                    }

                    Name (_SUN, Zero)  // _SUN: Slot User Number
                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                    {
                        Store (Package (0x08)
                            {
                                "built-in", 
                                Buffer (One)
                                {
                                     0x00                                             /* . */
                                }, 

                                "model", 
                                Buffer (0x10)
                                {
                                    "Apple WiFi card"
                                }, 

                                "device_type", 
                                Buffer (0x08)
                                {
                                    "Airport"
                                }, 

                                "empty", 
                                Zero
                            }, Local0)
                        DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                        Return (Local0)
                    }
                }

                Device (HDAU)
                {
                    Name (_ADR, One)  // _ADR: Address
                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                    {
                        Return (Zero)
                    }
                }
            }

            Device (GPP2)
            {
                Name (_ADR, 0x00010003)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    If (LEqual (WKPM, One))
                    {
                        Return (GPRW (0x08, 0x04))
                    }
                    Else
                    {
                        Return (GPRW (0x08, Zero))
                    }
                }

                Name (PR03, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        LNKA, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        LNKB, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKC, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKD, 
                        Zero
                    }
                })
                Name (AR03, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x13
                    }
                })
                Name (NR03, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x20
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x21
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x22
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x23
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        If (\NAPC)
                        {
                            Return (NR03) /* \_SB_.PCI0.GPP2.NR03 */
                        }
                        Else
                        {
                            Return (AR03) /* \_SB_.PCI0.GPP2.AR03 */
                        }
                    }
                    Else
                    {
                        Return (PR03) /* \_SB_.PCI0.GPP2.PR03 */
                    }
                }
            }

            Device (GPP3)
            {
                Name (_ADR, 0x00010004)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    If (LEqual (WKPM, One))
                    {
                        Return (GPRW (0x08, 0x04))
                    }
                    Else
                    {
                        Return (GPRW (0x08, Zero))
                    }
                }

                Name (PR04, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        LNKE, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        LNKF, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKG, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKH, 
                        Zero
                    }
                })
                Name (AR04, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x14
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x15
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x16
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x17
                    }
                })
                Name (NR04, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x24
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x25
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x26
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x27
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        If (\NAPC)
                        {
                            Return (NR04) /* \_SB_.PCI0.GPP3.NR04 */
                        }
                        Else
                        {
                            Return (AR04) /* \_SB_.PCI0.GPP3.AR04 */
                        }
                    }
                    Else
                    {
                        Return (PR04) /* \_SB_.PCI0.GPP3.PR04 */
                    }
                }
            }

            Device (GPP4)
            {
                Name (_ADR, 0x00010005)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    If (LEqual (WKPM, One))
                    {
                        Return (GPRW (0x08, 0x04))
                    }
                    Else
                    {
                        Return (GPRW (0x08, Zero))
                    }
                }

                Name (PR05, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        LNKA, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        LNKB, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKC, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKD, 
                        Zero
                    }
                })
                Name (AR05, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x13
                    }
                })
                Name (NR05, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x28
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x29
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x2A
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x2B
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        If (\NAPC)
                        {
                            Return (NR05) /* \_SB_.PCI0.GPP4.NR05 */
                        }
                        Else
                        {
                            Return (AR05) /* \_SB_.PCI0.GPP4.AR05 */
                        }
                    }
                    Else
                    {
                        Return (PR05) /* \_SB_.PCI0.GPP4.PR05 */
                    }
                }
            }

            Device (GPP5)
            {
                Name (_ADR, 0x00010006)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    If (LEqual (WKPM, One))
                    {
                        Return (GPRW (0x08, 0x04))
                    }
                    Else
                    {
                        Return (GPRW (0x08, Zero))
                    }
                }

                Name (PR06, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        LNKE, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        LNKF, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKG, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKH, 
                        Zero
                    }
                })
                Name (AR06, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x14
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x15
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x16
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x17
                    }
                })
                Name (NR06, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x2C
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x2D
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x2E
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x2F
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        If (\NAPC)
                        {
                            Return (NR06) /* \_SB_.PCI0.GPP5.NR06 */
                        }
                        Else
                        {
                            Return (AR06) /* \_SB_.PCI0.GPP5.AR06 */
                        }
                    }
                    Else
                    {
                        Return (PR06) /* \_SB_.PCI0.GPP5.PR06 */
                    }
                }
            }

            Device (GPP6)
            {
                Name (_ADR, 0x00010007)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    If (LEqual (WKPM, One))
                    {
                        Return (GPRW (0x08, 0x04))
                    }
                    Else
                    {
                        Return (GPRW (0x08, Zero))
                    }
                }

                Name (PR07, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        LNKA, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        LNKB, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKC, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKD, 
                        Zero
                    }
                })
                Name (AR07, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x13
                    }
                })
                Name (NR07, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x30
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x31
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x32
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x33
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        If (\NAPC)
                        {
                            Return (NR07) /* \_SB_.PCI0.GPP6.NR07 */
                        }
                        Else
                        {
                            Return (AR07) /* \_SB_.PCI0.GPP6.AR07 */
                        }
                    }
                    Else
                    {
                        Return (PR07) /* \_SB_.PCI0.GPP6.PR07 */
                    }
                }
            }

            Device (GP17)
            {
                Name (_ADR, 0x00080001)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    If (LEqual (WKPM, One))
                    {
                        Return (GPRW (0x19, 0x04))
                    }
                    Else
                    {
                        Return (GPRW (0x19, Zero))
                    }
                }

                Name (PR17, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        LNKE, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        LNKF, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKG, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKH, 
                        Zero
                    }
                })
                Name (AR17, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x14
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x15
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x16
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x17
                    }
                })
                Name (NR17, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x34
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x35
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x36
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x37
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        If (\NAPC)
                        {
                            Return (NR17) /* \_SB_.PCI0.GP17.NR17 */
                        }
                        Else
                        {
                            Return (AR17) /* \_SB_.PCI0.GP17.AR17 */
                        }
                    }
                    Else
                    {
                        Return (PR17) /* \_SB_.PCI0.GP17.PR17 */
                    }
                }

                Device (VGA)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }

                    Name (DOSA, Zero)
                    Method (_DOS, 1, NotSerialized)  // _DOS: Disable Output Switching
                    {
                        Store (Arg0, DOSA) /* \_SB_.PCI0.GP17.VGA_.DOSA */
                    }

                    Method (_DOD, 0, NotSerialized)  // _DOD: Display Output Devices
                    {
                        Return (Package (0x07)
                        {
                            0x00010110, 
                            0x00010210, 
                            0x00010220, 
                            0x00010230, 
                            0x00010240, 
                            0x00031000, 
                            0x00032000
                        })
                    }

                    Device (LCD)
                    {
                        Name (_ADR, 0x0110)  // _ADR: Address
                        Name (BCLB, Package (0x34)
                        {
                            0x5A, 
                            0x3C, 
                            0x02, 
                            0x04, 
                            0x06, 
                            0x08, 
                            0x0A, 
                            0x0C, 
                            0x0E, 
                            0x10, 
                            0x12, 
                            0x14, 
                            0x16, 
                            0x18, 
                            0x1A, 
                            0x1C, 
                            0x1E, 
                            0x20, 
                            0x22, 
                            0x24, 
                            0x26, 
                            0x28, 
                            0x2A, 
                            0x2C, 
                            0x2E, 
                            0x30, 
                            0x32, 
                            0x34, 
                            0x36, 
                            0x38, 
                            0x3A, 
                            0x3C, 
                            0x3E, 
                            0x40, 
                            0x42, 
                            0x44, 
                            0x46, 
                            0x48, 
                            0x4A, 
                            0x4C, 
                            0x4E, 
                            0x50, 
                            0x52, 
                            0x54, 
                            0x56, 
                            0x58, 
                            0x5A, 
                            0x5C, 
                            0x5E, 
                            0x60, 
                            0x62, 
                            0x64
                        })
                        Method (_BCL, 0, NotSerialized)  // _BCL: Brightness Control Levels
                        {
                            S80H (0x99)
                            Return (BCLB) /* \_SB_.PCI0.GP17.VGA_.LCD_.BCLB */
                        }

                        Method (_BCM, 1, NotSerialized)  // _BCM: Brightness Control Method
                        {
                            S80H (0x98)
                            Divide (Multiply (Arg0, 0xFF), 0x64, Local1, Local0)
                            AFN7 (Local0)
                            Store (Arg0, BRTL) /* \BRTL */
                        }
                    }

                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                    {
                        Store (Package (0x02)
                            {
                                "hda-gfx", 
                                Buffer (0x0A)
                                {
                                    "onboard-1"
                                }
                            }, Local0)
                        DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                        Return (Local0)
                    }

                    Name (_SUN, One)  // _SUN: Slot User Number
                }

                Device (PSP)
                {
                    Name (_ADR, 0x02)  // _ADR: Address
                }

                Device (ACP)
                {
                    Name (_ADR, 0x05)  // _ADR: Address
                }

                Device (HDAU)
                {
                    Name (_ADR, 0x06)  // _ADR: Address
                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                    {
                        Store (Package (0x06)
                            {
                                "hda-gfx", 
                                Buffer (0x0A)
                                {
                                    "onboard-1"
                                }, 

                                "layout-id", 
                                Buffer (0x04)
                                {
                                     0x01, 0x00, 0x00, 0x00                           /* .... */
                                }, 

                                "PinConfigurations", 
                                Buffer (0x04)
                                {
                                     0xE0, 0x00, 0x56, 0x28                           /* ..V( */
                                }
                            }, Local0)
                        DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                        Return (Local0)
                    }
                }

                Device (XHC0)
                {
                    Name (_ADR, 0x03)  // _ADR: Address
                    Method (_S0W, 0, NotSerialized)  // _S0W: S0 Device Wake State
                    {
                        Return (Zero)
                    }

                    Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                    {
                        If (LEqual (OWUS, One))
                        {
                            Return (GPRW (0x19, 0x03))
                        }
                        Else
                        {
                            Return (GPRW (0x19, Zero))
                        }
                    }

                    Device (RHUB)
                    {
                        Name (_ADR, Zero)  // _ADR: Address
                        Name (XUPC, Package (0x04)
                        {
                            0xFF, 
                            0xFF, 
                            Zero, 
                            Zero
                        })
                        Method (SUPC, 2, NotSerialized)
                        {
                            If (LNotEqual (Arg0, Zero))
                            {
                                Store (0xFF, Index (XUPC, Zero))
                                Store (Arg1, Index (XUPC, One))
                            }
                            Else
                            {
                                Store (Zero, Index (XUPC, Zero))
                                Store (0xFF, Index (XUPC, One))
                            }

                            Return (XUPC) /* \_SB_.PCI0.GP17.XHC0.RHUB.XUPC */
                        }

                        Name (XPLD, Package (0x01)
                        {
                            Buffer (0x14)
                            {
                                /* 0000 */  0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  /* ........ */
                                /* 0008 */  0x31, 0x9C, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,  /* 1....... */
                                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           /* .... */
                            }
                        })
                        Method (SPLD, 2, NotSerialized)
                        {
                            CreateField (DerefOf (Index (XPLD, Zero)), 0x40, One, UVSB)
                            CreateField (DerefOf (Index (XPLD, Zero)), 0x57, 0x08, GPPS)
                            CreateField (DerefOf (Index (XPLD, Zero)), 0x60, One, EJTB)
                            Store (Arg0, GPPS) /* \_SB_.PCI0.GP17.XHC0.RHUB.SPLD.GPPS */
                            Store (Arg1, UVSB) /* \_SB_.PCI0.GP17.XHC0.RHUB.SPLD.UVSB */
                            Store (Arg1, EJTB) /* \_SB_.PCI0.GP17.XHC0.RHUB.SPLD.EJTB */
                            Return (XPLD) /* \_SB_.PCI0.GP17.XHC0.RHUB.XPLD */
                        }

                        Device (PRT1)
                        {
                            Name (_ADR, One)  // _ADR: Address
                            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                            {
                                Return (SUPC (One, 0x09))
                            }

                            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                            {
                                Return (SPLD (One, One))
                            }
                        }

                        Device (PRT5)
                        {
                            Name (_ADR, 0x05)  // _ADR: Address
                            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                            {
                                Return (SUPC (One, 0x09))
                            }

                            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                            {
                                Return (SPLD (One, One))
                            }
                        }

                        Device (PRT2)
                        {
                            Name (_ADR, 0x02)  // _ADR: Address
                            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                            {
                                Return (SUPC (One, 0xFF))
                            }

                            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                            {
                                Return (SPLD (0x02, Zero))
                            }
                        }

                        Device (PRT6)
                        {
                            Name (_ADR, 0x06)  // _ADR: Address
                            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                            {
                                Return (SUPC (One, 0xFF))
                            }

                            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                            {
                                Return (SPLD (0x02, Zero))
                            }
                        }

                        Device (PRT3)
                        {
                            Name (_ADR, 0x03)  // _ADR: Address
                            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                            {
                                Return (SUPC (One, 0x03))
                            }

                            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                            {
                                Return (SPLD (0x03, One))
                            }
                        }

                        Device (PRT7)
                        {
                            Name (_ADR, 0x07)  // _ADR: Address
                            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                            {
                                Return (SUPC (One, 0x03))
                            }

                            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                            {
                                Return (SPLD (0x03, One))
                            }
                        }

                        Device (PRT4)
                        {
                            Name (_ADR, 0x04)  // _ADR: Address
                            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                            {
                                Return (SUPC (Zero, Zero))
                            }

                            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                            {
                                Store (Package (0x11)
                                    {
                                        "device-id", 
                                        Buffer (0x04)
                                        {
                                             0xE1, 0x15, 0x00, 0x00                           /* .... */
                                        }, 

                                        "built-in", 
                                        Buffer (One)
                                        {
                                             0x00                                             /* . */
                                        }, 

                                        "device_type", 
                                        Buffer (0x05)
                                        {
                                            "XHCI"
                                        }, 

                                        "AAPL,current-available", 
                                        0x0834, 
                                        "AAPL,current-extra", 
                                        0x0A8C, 
                                        "AAPL,current-in-sleep", 
                                        0x0A8C, 
                                        "AAPL,max-port-current-in-sleep", 
                                        0x0834, 
                                        "AAPL,device-internal", 
                                        Zero, 
                                        Buffer (One)
                                        {
                                             0x00                                             /* . */
                                        }
                                    }, Local0)
                                DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                                Return (Local0)
                            }
                        }

                        Device (PRT8)
                        {
                            Name (_ADR, 0x08)  // _ADR: Address
                            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                            {
                                Return (SUPC (Zero, Zero))
                            }
                        }
                    }

                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                    {
                        Store (Package (0x11)
                            {
                                "device-id", 
                                Buffer (0x04)
                                {
                                     0xE0, 0x15, 0x00, 0x00                           /* .... */
                                }, 

                                "built-in", 
                                Buffer (One)
                                {
                                     0x00                                             /* . */
                                }, 

                                "device_type", 
                                Buffer (0x05)
                                {
                                    "XHCI"
                                }, 

                                "AAPL,current-available", 
                                0x0834, 
                                "AAPL,current-extra", 
                                0x0A8C, 
                                "AAPL,current-in-sleep", 
                                0x0A8C, 
                                "AAPL,max-port-current-in-sleep", 
                                0x0834, 
                                "AAPL,device-internal", 
                                Zero, 
                                Buffer (One)
                                {
                                     0x00                                             /* . */
                                }
                            }, Local0)
                        DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                        Return (Local0)
                    }
                }

                Device (XHC1)
                {
                    Name (_ADR, 0x04)  // _ADR: Address
                    Method (_S0W, 0, NotSerialized)  // _S0W: S0 Device Wake State
                    {
                        Return (Zero)
                    }

                    Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                    {
                        If (LEqual (OWUS, One))
                        {
                            Return (GPRW (0x19, 0x03))
                        }
                        Else
                        {
                            Return (GPRW (0x19, Zero))
                        }
                    }

                    Device (RHUB)
                    {
                        Name (_ADR, Zero)  // _ADR: Address
                        Name (XUPC, Package (0x04)
                        {
                            0xFF, 
                            0xFF, 
                            Zero, 
                            Zero
                        })
                        Method (SUPC, 2, NotSerialized)
                        {
                            If (LNotEqual (Arg0, Zero))
                            {
                                Store (0xFF, Index (XUPC, Zero))
                                Store (Arg1, Index (XUPC, One))
                            }
                            Else
                            {
                                Store (Zero, Index (XUPC, Zero))
                                Store (0xFF, Index (XUPC, One))
                            }

                            Return (XUPC) /* \_SB_.PCI0.GP17.XHC1.RHUB.XUPC */
                        }

                        Name (XPLD, Package (0x01)
                        {
                            Buffer (0x14)
                            {
                                /* 0000 */  0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  /* ........ */
                                /* 0008 */  0x31, 0x9C, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,  /* 1....... */
                                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           /* .... */
                            }
                        })
                        Method (SPLD, 2, NotSerialized)
                        {
                            CreateField (DerefOf (Index (XPLD, Zero)), 0x40, One, UVSB)
                            CreateField (DerefOf (Index (XPLD, Zero)), 0x57, 0x08, GPPS)
                            CreateField (DerefOf (Index (XPLD, Zero)), 0x60, One, EJTB)
                            Store (Arg0, GPPS) /* \_SB_.PCI0.GP17.XHC1.RHUB.SPLD.GPPS */
                            Store (Arg1, UVSB) /* \_SB_.PCI0.GP17.XHC1.RHUB.SPLD.UVSB */
                            Store (Arg1, EJTB) /* \_SB_.PCI0.GP17.XHC1.RHUB.SPLD.EJTB */
                            Return (XPLD) /* \_SB_.PCI0.GP17.XHC1.RHUB.XPLD */
                        }

                        Device (PRT1)
                        {
                            Name (_ADR, One)  // _ADR: Address
                            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                            {
                                Return (SUPC (One, 0xFF))
                            }

                            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                            {
                                Return (SPLD (0x05, Zero))
                            }

                            Device (CCD0)
                            {
                                Name (_ADR, One)  // _ADR: Address
                                Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                                {
                                    Buffer (0x14)
                                    {
                                        /* 0000 */  0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  /* ........ */
                                        /* 0008 */  0x25, 0x1D, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  /* %....... */
                                        /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           /* .... */
                                        /*           Revision : 02     */
                                        /*        IgnoreColor : 01     */
                                        /*              Color : 000000 */
                                        /*              Width : 0000   */
                                        /*             Height : 0000   */
                                        /*        UserVisible : 01     */
                                        /*               Dock : 00     */
                                        /*                Lid : 01     */
                                        /*              Panel : 04     */
                                        /*   VerticalPosition : 00     */
                                        /* HorizontalPosition : 01     */
                                        /*              Shape : 07     */
                                        /*   GroupOrientation : 00     */
                                        /*         GroupToken : 00     */
                                        /*      GroupPosition : 00     */
                                        /*                Bay : 00     */
                                        /*          Ejectable : 00     */
                                        /*  OspmEjectRequired : 00     */
                                        /*      CabinetNumber : 00     */
                                        /*     CardCageNumber : 00     */
                                        /*          Reference : 00     */
                                        /*           Rotation : 00     */
                                        /*              Order : 00     */
                                        /*     VerticalOffset : FFFF   */
                                        /*   HorizontalOffset : FFFF   */
                                    }
                                })
                            }
                        }

                        Device (PRT2)
                        {
                            Name (_ADR, 0x02)  // _ADR: Address
                            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                            {
                                Return (SUPC (One, 0x03))
                            }

                            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                            {
                                Return (SPLD (0x06, One))
                            }
                        }

                        Device (PRT3)
                        {
                            Name (_ADR, 0x03)  // _ADR: Address
                            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                            {
                                Return (SUPC (Zero, Zero))
                            }
                        }
                    }
                }

                Device (MP2C)
                {
                    Name (_ADR, 0x07)  // _ADR: Address
                }
            }

            Device (GP18)
            {
                Name (_ADR, 0x00080002)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    If (LEqual (WKPM, One))
                    {
                        Return (GPRW (0x08, 0x04))
                    }
                    Else
                    {
                        Return (GPRW (0x08, Zero))
                    }
                }

                Name (PR18, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        LNKG, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        LNKH, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKE, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKF, 
                        Zero
                    }
                })
                Name (AR18, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x16
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x17
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x14
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x15
                    }
                })
                Name (NR18, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x36
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x37
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x34
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x35
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        If (\NAPC)
                        {
                            Return (NR18) /* \_SB_.PCI0.GP18.NR18 */
                        }
                        Else
                        {
                            Return (AR18) /* \_SB_.PCI0.GP18.AR18 */
                        }
                    }
                    Else
                    {
                        Return (PR18) /* \_SB_.PCI0.GP18.PR18 */
                    }
                }

                Device (SATA)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                }
            }

            Device (HPET)
            {
                Name (_HID, EisaId ("PNP0103") /* HPET System Timer */)  // _HID: Hardware ID
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If (LEqual (HPEN, One))
                    {
                        If (LGreaterEqual (OSTB, 0x40))
                        {
                            Return (0x0F)
                        }

                        Store (Zero, HPEN) /* \HPEN */
                        Return (One)
                    }

                    Return (One)
                }

                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (BUF0, ResourceTemplate ()
                    {
                        IRQNoFlags ()
                            {0}
                        IRQNoFlags ()
                            {8}
                        Memory32Fixed (ReadOnly,
                            0xFED00000,         // Address Base
                            0x00000400,         // Address Length
                            _Y07)
                    })
                    CreateDWordField (BUF0, \_SB.PCI0.HPET._CRS._Y07._BAS, HPEB)  // _BAS: Base Address
                    Store (0xFED00000, Local0)
                    And (Local0, 0xFFFFFC00, HPEB) /* \_SB_.PCI0.HPET._CRS.HPEB */
                    Return (BUF0) /* \_SB_.PCI0.HPET._CRS.BUF0 */
                }
            }

            Device (SMBS)
            {
                Name (_ADR, 0x00140000)  // _ADR: Address
                Device (BUS0)
                {
                    Name (_CID, "smbus")  // _CID: Compatible ID
                    Name (_ADR, Zero)  // _ADR: Address
                    Device (DVL0)
                    {
                        Name (_ADR, 0x57)  // _ADR: Address
                        Name (_CID, "diagsvault")  // _CID: Compatible ID
                        Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                        {
                            Store (Package (0x02)
                                {
                                    "address", 
                                    0x57
                                }, Local0)
                            DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                            Return (Local0)
                        }
                    }
                }
            }

            Device (LPC0)
            {
                Name (_ADR, 0x00140003)  // _ADR: Address
                Device (DMAC)
                {
                    Name (_HID, EisaId ("PNP0200") /* PC-class DMA Controller */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x01,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x0081,             // Range Minimum
                            0x0081,             // Range Maximum
                            0x01,               // Alignment
                            0x0F,               // Length
                            )
                        IO (Decode16,
                            0x00C0,             // Range Minimum
                            0x00C0,             // Range Maximum
                            0x01,               // Alignment
                            0x20,               // Length
                            )
                        DMA (Compatibility, NotBusMaster, Transfer8_16, )
                            {4}
                    })
                }

                Device (COPR)
                {
                    Name (_HID, EisaId ("PNP0C04") /* x87-compatible Floating Point Processing Unit */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x00F0,             // Range Minimum
                            0x00F0,             // Range Maximum
                            0x01,               // Alignment
                            0x0F,               // Length
                            )
                        IRQNoFlags ()
                            {13}
                    })
                }

                Device (PIC)
                {
                    Name (_HID, EisaId ("PNP0000") /* 8259-compatible Programmable Interrupt Controller */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0020,             // Range Minimum
                            0x0020,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A0,             // Range Minimum
                            0x00A0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                    })
                }

                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00") /* AT Real-Time Clock */)  // _HID: Hardware ID
                    Name (BUF0, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x00,               // Alignment
                            0x02,               // Length
                            )
                    })
                    Name (BUF1, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IRQNoFlags ()
                            {8}
                    })
                    Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                    {
                        If (LEqual (HPEN, One))
                        {
                            Return (BUF0) /* \_SB_.PCI0.LPC0.RTC_.BUF0 */
                        }

                        Return (BUF1) /* \_SB_.PCI0.LPC0.RTC_.BUF1 */
                    }
                }

                Device (TMR)
                {
                    Name (_HID, EisaId ("PNP0100") /* PC-class System Timer */)  // _HID: Hardware ID
                    Name (BUF0, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0040,             // Range Minimum
                            0x0040,             // Range Maximum
                            0x01,               // Alignment
                            0x04,               // Length
                            )
                    })
                    Name (BUF1, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0040,             // Range Minimum
                            0x0040,             // Range Maximum
                            0x01,               // Alignment
                            0x04,               // Length
                            )
                    })
                    Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                    {
                        If (LEqual (HPEN, One))
                        {
                            Return (BUF0) /* \_SB_.PCI0.LPC0.TMR_.BUF0 */
                        }

                        Return (BUF1) /* \_SB_.PCI0.LPC0.TMR_.BUF1 */
                    }
                }

                Device (KBC0)
                {
                    Name (_HID, "MSFT0001")  // _HID: Hardware ID
                    Name (_CID, EisaId ("PNP0303") /* IBM Enhanced Keyboard (101/102-key, PS/2 Mouse) */)  // _CID: Compatible ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }

                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0060,             // Range Minimum
                            0x0060,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0064,             // Range Minimum
                            0x0064,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IRQNoFlags ()
                            {1}
                    })
                }

                Device (PS2M)
                {
                    Name (_HID, "ETD2203")  // _HID: Hardware ID
                    Name (_CID, EisaId ("PNP0F13") /* PS/2 Mouse */)  // _CID: Compatible ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }

                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IRQNoFlags ()
                            {12}
                    })
                }

                Device (SYSR)
                {
                    Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                    Name (_UID, One)  // _UID: Unique ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0010,             // Range Minimum
                            0x0010,             // Range Maximum
                            0x01,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x0072,             // Range Minimum
                            0x0072,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0080,             // Range Minimum
                            0x0080,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x00B0,             // Range Minimum
                            0x00B0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0092,             // Range Minimum
                            0x0092,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0400,             // Range Minimum
                            0x0400,             // Range Maximum
                            0x01,               // Alignment
                            0xD0,               // Length
                            )
                        IO (Decode16,
                            0x04D0,             // Range Minimum
                            0x04D0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x04D6,             // Range Minimum
                            0x04D6,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0C00,             // Range Minimum
                            0x0C00,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0C14,             // Range Minimum
                            0x0C14,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0C50,             // Range Minimum
                            0x0C50,             // Range Maximum
                            0x01,               // Alignment
                            0x03,               // Length
                            )
                        IO (Decode16,
                            0x0C6C,             // Range Minimum
                            0x0C6C,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0C6F,             // Range Minimum
                            0x0C6F,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0CD0,             // Range Minimum
                            0x0CD0,             // Range Maximum
                            0x01,               // Alignment
                            0x0C,               // Length
                            )
                    })
                }

                Device (MEM)
                {
                    Name (_HID, EisaId ("PNP0C01") /* System Board */)  // _HID: Hardware ID
                    Name (MSRC, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly,
                            0x000E0000,         // Address Base
                            0x00020000,         // Address Length
                            )
                        Memory32Fixed (ReadWrite,
                            0xFFF00000,         // Address Base
                            0x00100000,         // Address Length
                            _Y08)
                    })
                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        CreateDWordField (MSRC, \_SB.PCI0.LPC0.MEM._Y08._LEN, PSIZ)  // _LEN: Length
                        CreateDWordField (MSRC, \_SB.PCI0.LPC0.MEM._Y08._BAS, PBAS)  // _BAS: Base Address
                        Store (ROMS, PSIZ) /* \_SB_.PCI0.LPC0.MEM_._CRS.PSIZ */
                        Subtract (ROMS, One, Local0)
                        Subtract (Ones, Local0, PBAS) /* \_SB_.PCI0.LPC0.MEM_._CRS.PBAS */
                        Return (MSRC) /* \_SB_.PCI0.LPC0.MEM_.MSRC */
                    }
                }

                Method (ECOK, 0, NotSerialized)
                {
                    If (LEqual (^EC0.OKEC, One))
                    {
                        Return (One)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Device (EC0)
                {
                    Name (_HID, EisaId ("PNP0C09") /* Embedded Controller Device */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0062,             // Range Minimum
                            0x0062,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0066,             // Range Minimum
                            0x0066,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                    })
                    Name (_GPE, 0x03)  // _GPE: General Purpose Events
                    Name (OKEC, Zero)
                    Method (_REG, 2, NotSerialized)  // _REG: Region Availability
                    {
                        If (LEqual (Arg0, 0x03))
                        {
                            Store (Arg1, OKEC) /* \_SB_.PCI0.LPC0.EC0_.OKEC */
                            If (LEqual (OKEC, One))
                            {
                                Notify (LID0, 0x80) // Status Change
                            }

                            Store (Zero, BPWC) /* \_SB_.PCI0.LPC0.EC0_.BPWC */
                            Store (Zero, BPWR) /* \_SB_.PCI0.LPC0.EC0_.BPWR */
                            Store (0x02, CPSM) /* \_SB_.PCI0.LPC0.EC0_.CPSM */
                            CTDP ()
                            SELE ()
                        }
                    }

                    OperationRegion (ERAM, SystemMemory, 0xFF708300, 0x0100)
                    Field (ERAM, ByteAcc, Lock, Preserve)
                    {
                        VERM,   8, 
                        VERS,   8, 
                        VERT,   8, 
                        Offset (0x04), 
                        YEAR,   8, 
                        MONT,   8, 
                        DAYS,   8, 
                        Offset (0x0C), 
                        BPWC,   8, 
                        BPWR,   8, 
                        Offset (0x10), 
                        LSTE,   1, 
                        Offset (0x12), 
                            ,   7, 
                        LPBF,   1, 
                        Offset (0x15), 
                        FNIS,   1, 
                        FNKL,   1, 
                            ,   2, 
                        WKYS,   1, 
                        Offset (0x16), 
                            ,   4, 
                        MICL,   1, 
                        Offset (0x17), 
                        ERRL,   8, 
                        Offset (0x1A), 
                            ,   2, 
                        NMIT,   1, 
                        Offset (0x1C), 
                            ,   1, 
                        SPMD,   1, 
                            ,   1, 
                            ,   1, 
                        WDTE,   1, 
                        WDBE,   1, 
                            ,   1, 
                        WDSE,   1, 
                        Offset (0x20), 
                        CTMP,   8, 
                        Offset (0x22), 
                        Offset (0x23), 
                        Offset (0x24), 
                        DNTC,   8, 
                        CNTC,   8, 
                        STM0,   8, 
                        TNTC,   8, 
                        STM1,   8, 
                        STM2,   8, 
                        Offset (0x2B), 
                        BTMP,   8, 
                        Offset (0x30), 
                        BDNA,   120, 
                        BDBC,   8, 
                        Offset (0x4C), 
                        UTYC,   8, 
                        DTYC,   8, 
                        UCHA,   8, 
                        DCHA,   8, 
                        Offset (0x54), 
                        SPDT,   8, 
                        GPPT,   8, 
                        DFDI,   8, 
                        DFDC,   8, 
                        Offset (0x59), 
                        CPSS,   8, 
                        CPSC,   8, 
                        CPSM,   8, 
                        BCCL,   8, 
                        BCCH,   8, 
                        Offset (0x60), 
                        BNAM,   152, 
                        BNBC,   8, 
                        Offset (0x7A), 
                        BTCC,   16, 
                        Offset (0x7E), 
                        BATL,   8, 
                        BATH,   8, 
                        ACDC,   1, 
                        BST1,   1, 
                        BST2,   1, 
                        Offset (0x81), 
                        BTML,   8, 
                        BTSN,   16, 
                        BTAP,   16, 
                        BTDV,   16, 
                        BLFC,   16, 
                        BTTP,   16, 
                        BSTI,   1, 
                        BSTV,   1, 
                        BSTC,   1, 
                        BSTF,   1, 
                        BSTD,   1, 
                        BSDD,   1, 
                        BSAN,   1, 
                        CHEM,   1, 
                        SBDC,   1, 
                        SBWC,   1, 
                        SBPC,   1, 
                        SBNC,   1, 
                        BIDC,   1, 
                        BIWC,   1, 
                        BIPC,   1, 
                        BINC,   1, 
                        BT1I,   16, 
                        BT1V,   16, 
                        BT1C,   16, 
                        BTFC,   16, 
                        B1CC,   16, 
                        B1CV,   16, 
                        BT1T,   16, 
                            ,   4, 
                        ISFD,   1, 
                        ISFC,   1, 
                        ISDC,   1, 
                        ISGI,   1, 
                        IART,   1, 
                        IARC,   1, 
                            ,   1, 
                        IATD,   1, 
                        IAOT,   1, 
                            ,   1, 
                        IATC,   1, 
                        IAOC,   1, 
                        RSOC,   16, 
                        Offset (0xC0), 
                        ALD0,   8, 
                        ALD1,   8, 
                        ALD2,   8, 
                        ALD3,   8, 
                        ALD4,   8, 
                        ALD5,   8, 
                        ALD6,   8, 
                        ALD7,   8, 
                        ALD8,   8, 
                        ALD9,   8, 
                        Offset (0xCC), 
                        FRHI,   8, 
                        FRLO,   8, 
                        Offset (0xD0), 
                        UCPU,   8, 
                        DCPU,   8, 
                        UDDR,   8, 
                        DDDR,   8, 
                        UGPE,   8, 
                        DGPE,   8, 
                        Offset (0xDC), 
                        CPUF,   1, 
                        BAUF,   1, 
                        SYUF,   1, 
                        DRUF,   1, 
                        PHUF,   1, 
                        GPUF,   1, 
                        TCUF,   1, 
                        CHUF,   1, 
                        CPDF,   1, 
                        BADF,   1, 
                        SYDF,   1, 
                        DRDF,   1, 
                        PHDF,   1, 
                        GPDF,   1, 
                        TCDF,   1, 
                        CHDF,   1, 
                        TFUC,   1, 
                        TFUB,   1, 
                        TFUL,   1, 
                        TFUD,   1, 
                        TFUR,   1, 
                        TFUG,   1, 
                        TFUT,   1, 
                        TFUH,   1, 
                        TFDC,   1, 
                        TFDB,   1, 
                        TFDL,   1, 
                        TFDD,   1, 
                        TFDR,   1, 
                        TFDG,   1, 
                        TFDT,   1, 
                        TFDH,   1, 
                        SSWS,   8, 
                        Offset (0xE8), 
                        PADH,   8, 
                        PADL,   8, 
                        PBTH,   8, 
                        PBTL,   8, 
                        EWTH,   8, 
                        EWTL,   8, 
                        Offset (0xF0), 
                        SDSR,   8, 
                        WUSR,   8, 
                        Offset (0xFC), 
                        KCMS,   8
                    }

                    Field (ERAM, ByteAcc, Lock, Preserve)
                    {
                        Offset (0x7E), 
                        BATD,   16
                    }

                    OperationRegion (CRAM, SystemMemory, 0xFF708C00, 0x0100)
                    Field (CRAM, ByteAcc, Lock, Preserve)
                    {
                        Offset (0xA0), 
                        VER1,   8, 
                        VER2,   8, 
                        RSV1,   8, 
                        RSV2,   8, 
                        CCI0,   8, 
                        CCI1,   8, 
                        CCI2,   8, 
                        CCI3,   8, 
                        CTL0,   8, 
                        CTL1,   8, 
                        CTL2,   8, 
                        CTL3,   8, 
                        CTL4,   8, 
                        CTL5,   8, 
                        CTL6,   8, 
                        CTL7,   8, 
                        MGI0,   8, 
                        MGI1,   8, 
                        MGI2,   8, 
                        MGI3,   8, 
                        MGI4,   8, 
                        MGI5,   8, 
                        MGI6,   8, 
                        MGI7,   8, 
                        MGI8,   8, 
                        MGI9,   8, 
                        MGIA,   8, 
                        MGIB,   8, 
                        MGIC,   8, 
                        MGID,   8, 
                        MGIE,   8, 
                        MGIF,   8, 
                        MGO0,   8, 
                        MGO1,   8, 
                        MGO2,   8, 
                        MGO3,   8, 
                        MGO4,   8, 
                        MGO5,   8, 
                        MGO6,   8, 
                        MGO7,   8, 
                        MGO8,   8, 
                        MGO9,   8, 
                        MGOA,   8, 
                        MGOB,   8, 
                        MGOC,   8, 
                        MGOD,   8, 
                        MGOE,   8, 
                        MGOF,   8
                    }

                    OperationRegion (ECIO, SystemIO, 0x60, 0x10)
                    Field (ECIO, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x02), 
                        EDAT,   8, 
                        Offset (0x06), 
                        CMDS,   8
                    }

                    Method (IBE2, 0, Serialized)
                    {
                        While (And (CMDS, 0x02))
                        {
                            Sleep (0x50)
                        }
                    }

                    Method (ECMD, 1, Serialized)
                    {
                        IBE2 ()
                        Store (Arg0, CMDS) /* \_SB_.PCI0.LPC0.EC0_.CMDS */
                        IBE2 ()
                    }

                    Method (ECDW, 1, Serialized)
                    {
                        IBE2 ()
                        Store (Arg0, EDAT) /* \_SB_.PCI0.LPC0.EC0_.EDAT */
                        IBE2 ()
                    }

                    Method (_Q01, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Notify (^^^GP17.VGA.LCD, 0x87) // Device-Specific
                        Store (0x0281, ^^^^WMI1.WMEN) /* External reference */
                        Notify (WMI1, 0xA0) // Device-Specific
                    }

                    Method (_Q02, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Notify (^^^GP17.VGA.LCD, 0x86) // Device-Specific
                        Store (0x0282, ^^^^WMI1.WMEN) /* External reference */
                        Notify (WMI1, 0xA0) // Device-Specific
                    }

                    Method (_Q03, 0, NotSerialized)  // _Qxx: EC Query
                    {
                    }

                    Method (_Q04, 0, NotSerialized)  // _Qxx: EC Query
                    {
                    }

                    Method (_Q05, 0, NotSerialized)  // _Qxx: EC Query
                    {
                    }

                    Method (_Q06, 0, NotSerialized)  // _Qxx: EC Query
                    {
                    }

                    Method (_Q07, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Store (0x0287, ^^^^WMI1.WMEN) /* External reference */
                        Notify (WMI1, 0xA0) // Device-Specific
                    }

                    Method (_Q08, 0, NotSerialized)  // _Qxx: EC Query
                    {
                    }

                    Method (_Q09, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Store (0x0289, ^^^^WMI1.WMEN) /* External reference */
                        Notify (WMI1, 0xA0) // Device-Specific
                    }

                    Method (_Q0A, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Store (0x028A, ^^^^WMI1.WMEN) /* External reference */
                        Notify (WMI1, 0xA0) // Device-Specific
                    }

                    Method (_Q0B, 0, NotSerialized)  // _Qxx: EC Query
                    {
                    }

                    Method (_Q0C, 0, NotSerialized)  // _Qxx: EC Query
                    {
                    }

                    Method (_Q0D, 0, NotSerialized)  // _Qxx: EC Query
                    {
                    }

                    Method (_Q10, 0, NotSerialized)  // _Qxx: EC Query
                    {
                    }

                    Method (_Q11, 0, NotSerialized)  // _Qxx: EC Query
                    {
                    }

                    Method (_Q12, 0, NotSerialized)  // _Qxx: EC Query
                    {
                    }

                    Method (_Q13, 0, NotSerialized)  // _Qxx: EC Query
                    {
                    }

                    Method (_Q14, 0, NotSerialized)  // _Qxx: EC Query
                    {
                    }

                    Method (_Q15, 0, NotSerialized)  // _Qxx: EC Query
                    {
                    }

                    Method (_Q16, 0, NotSerialized)  // _Qxx: EC Query
                    {
                    }

                    Method (_Q17, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Notify (^^^GP17.VGA.LCD, 0x86) // Device-Specific
                    }

                    Method (_Q18, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Notify (^^^GP17.VGA.LCD, 0x87) // Device-Specific
                    }

                    Method (_Q19, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Notify (LID0, 0x80) // Status Change
                    }

                    Method (_Q1A, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Notify (LID0, 0x80) // Status Change
                    }

                    Method (_Q20, 0, NotSerialized)  // _Qxx: EC Query
                    {
                    }

                    Method (_Q21, 0, NotSerialized)  // _Qxx: EC Query
                    {
                    }

                    Method (_Q30, 0, NotSerialized)  // _Qxx: EC Query
                    {
                    }

                    Method (_Q38, 0, NotSerialized)  // _Qxx: EC Query
                    {
                    }

                    Method (_Q31, 0, NotSerialized)  // _Qxx: EC Query
                    {
                    }

                    Method (_Q32, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        If (ECOK ())
                        {
                            Notify (ADP1, 0x80) // Status Change
                        }
                    }

                    Method (_Q33, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        If (ECOK ())
                        {
                            Notify (BAT1, 0x80) // Status Change
                        }
                    }

                    Method (_Q34, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        If (ECOK ())
                        {
                            Notify (BAT1, 0x81) // Information Change
                        }
                    }

                    Method (_Q35, 0, NotSerialized)  // _Qxx: EC Query
                    {
                    }

                    Method (_Q36, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        If (ECOK ())
                        {
                            Notify (BAT1, 0x80) // Status Change
                        }
                    }

                    Method (_Q37, 0, NotSerialized)  // _Qxx: EC Query
                    {
                    }

                    Method (_Q3F, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        If (ECOK ())
                        {
                            S80H (0x3E)
                            SELE ()
                            Notify (ADP1, 0x80) // Status Change
                            Notify (BAT1, 0x80) // Status Change
                            S80H (0x3F)
                        }
                    }

                    Method (_Q79, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        ^^^^UBTC.M318 ()
                        Notify (UBTC, 0x80) // Status Change
                    }

                    Method (_QA6, 0, Serialized)  // _Qxx: EC Query
                    {
                        Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
                        While (One)
                        {
                            Store (ToInteger (CPSC), _T_0) /* \_SB_.PCI0.LPC0.EC0_._QA6._T_0 */
                            If (LEqual (_T_0, One))
                            {
                                Store (Zero, CPSC) /* \_SB_.PCI0.LPC0.EC0_.CPSC */
                            }
                            Else
                            {
                                If (LEqual (_T_0, 0x02))
                                {
                                    Store (One, CPSC) /* \_SB_.PCI0.LPC0.EC0_.CPSC */
                                }
                            }

                            Break
                        }

                        Store (CPSC, \_PR.C000.PPCV) /* External reference */
                        Notify (\_PR.C000, 0x80) // Performance Capability Change
                        Sleep (0x64)
                        Store (CPSC, \_PR.C001.PPCV) /* External reference */
                        Notify (\_PR.C001, 0x80) // Performance Capability Change
                        Sleep (0x64)
                        Store (CPSC, \_PR.C002.PPCV) /* External reference */
                        Notify (\_PR.C002, 0x80) // Performance Capability Change
                        Sleep (0x64)
                        Store (CPSC, \_PR.C003.PPCV) /* External reference */
                        Notify (\_PR.C003, 0x80) // Performance Capability Change
                        Sleep (0x64)
                        Store (CPSC, \_PR.C004.PPCV) /* External reference */
                        Notify (\_PR.C004, 0x80) // Performance Capability Change
                        Sleep (0x64)
                        Store (CPSC, \_PR.C005.PPCV) /* External reference */
                        Notify (\_PR.C005, 0x80) // Performance Capability Change
                        Sleep (0x64)
                        Store (CPSC, \_PR.C006.PPCV) /* External reference */
                        Notify (\_PR.C006, 0x80) // Performance Capability Change
                        Sleep (0x64)
                        Store (CPSC, \_PR.C007.PPCV) /* External reference */
                        Notify (\_PR.C007, 0x80) // Performance Capability Change
                        Sleep (0x64)
                    }

                    Method (_QA7, 0, Serialized)  // _Qxx: EC Query
                    {
                        Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
                        While (One)
                        {
                            Store (ToInteger (CPSC), _T_0) /* \_SB_.PCI0.LPC0.EC0_._QA7._T_0 */
                            If (LEqual (_T_0, Zero))
                            {
                                Store (One, CPSC) /* \_SB_.PCI0.LPC0.EC0_.CPSC */
                            }
                            Else
                            {
                                If (LEqual (_T_0, One))
                                {
                                    Store (0x02, CPSC) /* \_SB_.PCI0.LPC0.EC0_.CPSC */
                                }
                            }

                            Break
                        }

                        Store (CPSC, \_PR.C000.PPCV) /* External reference */
                        Notify (\_PR.C000, 0x80) // Performance Capability Change
                        Sleep (0x64)
                        Store (CPSC, \_PR.C001.PPCV) /* External reference */
                        Notify (\_PR.C001, 0x80) // Performance Capability Change
                        Sleep (0x64)
                        Store (CPSC, \_PR.C002.PPCV) /* External reference */
                        Notify (\_PR.C002, 0x80) // Performance Capability Change
                        Sleep (0x64)
                        Store (CPSC, \_PR.C003.PPCV) /* External reference */
                        Notify (\_PR.C003, 0x80) // Performance Capability Change
                        Sleep (0x64)
                        Store (CPSC, \_PR.C004.PPCV) /* External reference */
                        Notify (\_PR.C004, 0x80) // Performance Capability Change
                        Sleep (0x64)
                        Store (CPSC, \_PR.C005.PPCV) /* External reference */
                        Notify (\_PR.C005, 0x80) // Performance Capability Change
                        Sleep (0x64)
                        Store (CPSC, \_PR.C006.PPCV) /* External reference */
                        Notify (\_PR.C006, 0x80) // Performance Capability Change
                        Sleep (0x64)
                        Store (CPSC, \_PR.C007.PPCV) /* External reference */
                        Notify (\_PR.C007, 0x80) // Performance Capability Change
                        Sleep (0x64)
                    }

                    Method (_QDC, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Store (One, TCUF) /* \_SB_.PCI0.LPC0.EC0_.TCUF */
                        Store (0x0107, ^^^^WMI1.WMEN) /* External reference */
                        Notify (WMI1, 0xA0) // Device-Specific
                    }

                    Method (_QDD, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Store (One, TCDF) /* \_SB_.PCI0.LPC0.EC0_.TCDF */
                        Store (0x0107, ^^^^WMI1.WMEN) /* External reference */
                        Notify (WMI1, 0xA0) // Device-Specific
                    }

                    Method (_QDE, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Store (One, CHUF) /* \_SB_.PCI0.LPC0.EC0_.CHUF */
                        Store (0x0108, ^^^^WMI1.WMEN) /* External reference */
                        Notify (WMI1, 0xA0) // Device-Specific
                    }

                    Method (_QDF, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Store (One, CHDF) /* \_SB_.PCI0.LPC0.EC0_.CHDF */
                        Store (0x0108, ^^^^WMI1.WMEN) /* External reference */
                        Notify (WMI1, 0xA0) // Device-Specific
                    }

                    Method (_QE0, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Store (One, CPUF) /* \_SB_.PCI0.LPC0.EC0_.CPUF */
                        Store (0x0100, ^^^^WMI1.WMEN) /* External reference */
                        Notify (WMI1, 0xA0) // Device-Specific
                    }

                    Method (_QE1, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Store (One, CPDF) /* \_SB_.PCI0.LPC0.EC0_.CPDF */
                        Store (0x0100, ^^^^WMI1.WMEN) /* External reference */
                        Notify (WMI1, 0xA0) // Device-Specific
                    }

                    Method (_QE6, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Store (One, DRUF) /* \_SB_.PCI0.LPC0.EC0_.DRUF */
                        Store (0x010B, ^^^^WMI1.WMEN) /* External reference */
                        Notify (WMI1, 0xA0) // Device-Specific
                    }

                    Method (_QE7, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Store (One, DRDF) /* \_SB_.PCI0.LPC0.EC0_.DRDF */
                        Store (0x010B, ^^^^WMI1.WMEN) /* External reference */
                        Notify (WMI1, 0xA0) // Device-Specific
                    }

                    Method (_QEA, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Store (One, GPUF) /* \_SB_.PCI0.LPC0.EC0_.GPUF */
                        Store (0x0105, ^^^^WMI1.WMEN) /* External reference */
                        Notify (WMI1, 0xA0) // Device-Specific
                    }

                    Method (_QEB, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Store (One, GPDF) /* \_SB_.PCI0.LPC0.EC0_.GPDF */
                        Store (0x0105, ^^^^WMI1.WMEN) /* External reference */
                        Notify (WMI1, 0xA0) // Device-Specific
                    }

                    Method (_QEC, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Name (USPL, Buffer (0x08) {})
                        CreateWordField (USPL, Zero, M254)
                        CreateByteField (USPL, 0x02, M255)
                        CreateDWordField (USPL, 0x03, M256)
                        Store (0x07, M254) /* \_SB_.PCI0.LPC0.EC0_._QEC.M254 */
                        Store (0x05, M255) /* \_SB_.PCI0.LPC0.EC0_._QEC.M255 */
                        Store (Multiply (SSWS, 0x03E8), M256) /* \_SB_.PCI0.LPC0.EC0_._QEC.M256 */
                        ALIB (0x0C, USPL)
                    }

                    Method (_QED, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Name (DSPL, Buffer (0x08) {})
                        CreateWordField (DSPL, Zero, M254)
                        CreateByteField (DSPL, 0x02, M255)
                        CreateDWordField (DSPL, 0x03, M256)
                        Store (0x07, M254) /* \_SB_.PCI0.LPC0.EC0_._QED.M254 */
                        Store (0x05, M255) /* \_SB_.PCI0.LPC0.EC0_._QED.M255 */
                        Store (Multiply (SSWS, 0x03E8), M256) /* \_SB_.PCI0.LPC0.EC0_._QED.M256 */
                        ALIB (0x0C, DSPL)
                    }

                    Name (BATO, 0xC0)
                    Name (BATN, Zero)
                    Method (SELE, 0, Serialized)
                    {
                        Store (BATD, BATN) /* \_SB_.PCI0.LPC0.EC0_.BATN */
                        If (And (BATN, One))
                        {
                            Store (0x1F, ^^^^BAT1.BATP) /* \_SB_.BAT1.BATP */
                        }
                        Else
                        {
                            If (LAnd (LEqual (And (BATO, 0xC1), One), LEqual (And (
                                BATN, 0xC1), 0xC0)))
                            {
                                Store (One, ^^^^ADP1.ACRT) /* \_SB_.ADP1.ACRT */
                                Notify (ADP1, 0x80) // Status Change
                                Sleep (0x0A)
                                Store (0x0A, Local1)
                                While (Local1)
                                {
                                    If (^^^^ADP1.ACRT)
                                    {
                                        Sleep (0x14)
                                        Notify (ADP1, 0x80) // Status Change
                                        Decrement (Local1)
                                    }
                                    Else
                                    {
                                        Store (Zero, Local1)
                                    }
                                }
                            }

                            Store (0x0F, ^^^^BAT1.BATP) /* \_SB_.BAT1.BATP */
                        }

                        If (LNotEqual (And (BATN, 0x0FFF), And (BATO, 0x0FFF
                            )))
                        {
                            Notify (BAT1, 0x81) // Information Change
                            Notify (BAT1, One) // Device Check
                            If (LAnd (LEqual (And (BATO, One), One), LEqual (And (
                                BATN, One), Zero)))
                            {
                                Sleep (0x14)
                            }
                        }

                        Store (BATN, BATO) /* \_SB_.PCI0.LPC0.EC0_.BATO */
                    }

                    Method (CHKB, 0, NotSerialized)
                    {
                        If (LEqual (^^^^BAT1.BATP, 0x1F))
                        {
                            If (LNotEqual (DerefOf (Index (^^^^BAT1.PBIF, One)), BTAP))
                            {
                                Notify (BAT1, 0x81) // Information Change
                                Notify (BAT1, One) // Device Check
                            }
                        }
                    }

                    Method (ALIL, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, Zero, A104)
                        Store (Buffer (0x18) {}, Local7)
                        CreateDWordField (Local7, Zero, A006)
                        CreateDWordField (Local7, 0x04, A007)
                        CreateDWordField (Local7, 0x08, A008)
                        CreateDWordField (Local7, 0x0C, A009)
                        CreateDWordField (Local7, 0x10, A010)
                        CreateDWordField (Local7, 0x14, A011)
                        Store (0x02, Local0)
                        While (LLess (Local0, A104))
                        {
                            Store (DerefOf (Index (Arg0, Local0)), Local1)
                            Increment (Local0)
                            Store (DerefOf (Index (Arg0, Local0)), Local2)
                            Increment (Local0)
                            Or (ShiftLeft (DerefOf (Index (Arg0, Local0)), 0x08), Local2, 
                                Local2)
                            Increment (Local0)
                            Or (ShiftLeft (DerefOf (Index (Arg0, Local0)), 0x10), Local2, 
                                Local2)
                            Increment (Local0)
                            Or (ShiftLeft (DerefOf (Index (Arg0, Local0)), 0x18), Local2, 
                                Local2)
                            Increment (Local0)
                            Store (Zero, A006) /* \_SB_.PCI0.LPC0.EC0_.ALIL.A006 */
                            Store (Zero, A007) /* \_SB_.PCI0.LPC0.EC0_.ALIL.A007 */
                            Store (Zero, A008) /* \_SB_.PCI0.LPC0.EC0_.ALIL.A008 */
                            Store (Zero, A009) /* \_SB_.PCI0.LPC0.EC0_.ALIL.A009 */
                            Store (Zero, A010) /* \_SB_.PCI0.LPC0.EC0_.ALIL.A010 */
                            Store (Zero, A011) /* \_SB_.PCI0.LPC0.EC0_.ALIL.A011 */
                            Store (Local2, A006) /* \_SB_.PCI0.LPC0.EC0_.ALIL.A006 */
                            A012 (Local1, Local7)
                        }
                    }

                    Method (CTDP, 0, NotSerialized)
                    {
                        Name (UTDP, Buffer (0x08) {})
                        CreateWordField (UTDP, Zero, M254)
                        CreateByteField (UTDP, 0x02, M255)
                        CreateDWordField (UTDP, 0x03, M256)
                        Store (0x07, M254) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M254 */
                        Store (0x1A, M255) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M255 */
                        Store (0x9088, M256) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M256 */
                        ALIL (UTDP)
                        Store (0x1B, M255) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M255 */
                        Store (0xA410, M256) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M256 */
                        ALIL (UTDP)
                        Store (0x1C, M255) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M255 */
                        Store (0x9C40, M256) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M256 */
                        ALIL (UTDP)
                        Store (0x1D, M255) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M255 */
                        Store (0x0E, M256) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M256 */
                        ALIL (UTDP)
                        Store (0x1E, M255) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M255 */
                        Store (0x60, M256) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M256 */
                        ALIL (UTDP)
                        Store (0x1F, M255) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M255 */
                        Store (0x73, M256) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M256 */
                        ALIL (UTDP)
                        Store (0x20, M255) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M255 */
                        Store (0x11940, M256) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M256 */
                        ALIL (UTDP)
                        Store (0x21, M255) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M255 */
                        Store (0x2134, M256) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M256 */
                        ALIL (UTDP)
                        Store (0x22, M255) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M255 */
                        Store (0x14438, M256) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M256 */
                        ALIL (UTDP)
                        Store (0x23, M255) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M255 */
                        Store (0x2134, M256) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M256 */
                        ALIL (UTDP)
                        Store (0x24, M255) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M255 */
                        Store (0x14438, M256) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M256 */
                        ALIL (UTDP)
                        Store (0x25, M255) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M255 */
                        Store (0x2134, M256) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M256 */
                        ALIL (UTDP)
                        Store (0x26, M255) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M255 */
                        Store (0x01, M256) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M256 */
                        ALIL (UTDP)
                        Store (0x48, M255) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M255 */
                        Store (0x2F5, M256) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M256 */
                        ALIL (UTDP)
                        Store (0x49, M255) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M255 */
                        Store (0x2F5, M256) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M256 */
                        ALIL (UTDP)
                        Store (0x4A, M255) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M255 */
                        Store (0x4B0, M256) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M256 */
                        ALIL (UTDP)
                        Store (0x4B, M255) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M255 */
                        Store (0x4B0, M256) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M256 */
                        ALIL (UTDP)
                        Store (0x4C, M255) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M255 */
                        Store (0x3C00320, M256) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M256 */
                        ALIL (UTDP)
                        Store (0x4D, M255) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M255 */
                        Store (0x3C00320, M256) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M256 */
                        ALIL (UTDP)
                        Store (0x4E, M255) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M255 */
                        Store (0x1B4, M256) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M256 */
                        ALIL (UTDP)
                        Store (0x4F, M255) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M255 */
                        Store (0x1B4, M256) /* \_SB_.PCI0.LPC0.EC0_.CTDP.M256 */
                        ALIL (UTDP)
                    }
                }

                Mutex (PSMX, 0x00)
            }

            Device (HDEF)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
                    Store (Package (0x04)
                        {
                            "MaximumBootBeepVolume", 
                            Buffer (One)
                            {
                                 0x01                                             /* . */
                            }, 

                            "PinConfigurations", 
                            Buffer (Zero) {}
                        }, Local0)
                    DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                    Return (Local0)
                }
            }

            Device (IMEI)
            {
                Name (_ADR, Zero)  // _ADR: Address
            }
        }

        OperationRegion (PIRQ, SystemIO, 0x0C00, 0x02)
        Field (PIRQ, ByteAcc, NoLock, Preserve)
        {
            PIDX,   8, 
            PDAT,   8
        }

        IndexField (PIDX, PDAT, ByteAcc, NoLock, Preserve)
        {
            PIRA,   8, 
            PIRB,   8, 
            PIRC,   8, 
            PIRD,   8, 
            PIRE,   8, 
            PIRF,   8, 
            PIRG,   8, 
            PIRH,   8, 
            Offset (0x0C), 
            SIRA,   8, 
            SIRB,   8, 
            SIRC,   8, 
            SIRD,   8, 
            PIRS,   8, 
            Offset (0x13), 
            HDAD,   8, 
            Offset (0x17), 
            SDCL,   8, 
            Offset (0x1A), 
            SDIO,   8, 
            Offset (0x30), 
            USB1,   8, 
            Offset (0x34), 
            USB3,   8, 
            Offset (0x41), 
            SATA,   8, 
            Offset (0x62), 
            GIOC,   8, 
            Offset (0x70), 
            I2C0,   8, 
            I2C1,   8, 
            I2C2,   8, 
            I2C3,   8, 
            URT0,   8, 
            URT1,   8
        }

        OperationRegion (KBDD, SystemIO, 0x64, One)
        Field (KBDD, ByteAcc, NoLock, Preserve)
        {
            PD64,   8
        }

        Method (DSPI, 0, NotSerialized)
        {
            INTA (0x1F)
            INTB (0x1F)
            INTC (0x1F)
            INTD (0x1F)
            Store (PD64, Local1)
            Store (0x1F, PIRE) /* \_SB_.PIRE */
            Store (0x1F, PIRF) /* \_SB_.PIRF */
            Store (0x1F, PIRG) /* \_SB_.PIRG */
            Store (0x1F, PIRH) /* \_SB_.PIRH */
        }

        Method (INTA, 1, NotSerialized)
        {
            Store (Arg0, PIRA) /* \_SB_.PIRA */
            If (PICM)
            {
                Store (Arg0, HDAD) /* \_SB_.HDAD */
                Store (Arg0, SDCL) /* \_SB_.SDCL */
            }
        }

        Method (INTB, 1, NotSerialized)
        {
            Store (Arg0, PIRB) /* \_SB_.PIRB */
        }

        Method (INTC, 1, NotSerialized)
        {
            Store (Arg0, PIRC) /* \_SB_.PIRC */
            If (PICM)
            {
                Store (Arg0, USB1) /* \_SB_.USB1 */
                Store (Arg0, USB3) /* \_SB_.USB3 */
            }
        }

        Method (INTD, 1, NotSerialized)
        {
            Store (Arg0, PIRD) /* \_SB_.PIRD */
            If (PICM)
            {
                Store (Arg0, SATA) /* \_SB_.SATA */
            }
        }

        Name (PRS1, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {3,5,6,10,11}
        })
        Name (BUFA, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {15}
        })
        Device (LNKA)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (LAnd (PIRA, LNotEqual (PIRA, 0x1F)))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (0x09)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRS1) /* \_SB_.PRS1 */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                INTA (0x1F)
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (BUFA, One, IRQX)
                ShiftLeft (One, PIRA, IRQX) /* \_SB_.LNKA._CRS.IRQX */
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Decrement (Local0)
                Store (Local0, PIRA) /* \_SB_.PIRA */
            }
        }

        Device (LNKB)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (LAnd (PIRB, LNotEqual (PIRB, 0x1F)))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (0x09)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRS1) /* \_SB_.PRS1 */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                INTB (0x1F)
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (BUFA, One, IRQX)
                ShiftLeft (One, PIRB, IRQX) /* \_SB_.LNKB._CRS.IRQX */
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Decrement (Local0)
                Store (Local0, PIRB) /* \_SB_.PIRB */
            }
        }

        Device (LNKC)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (LAnd (PIRC, LNotEqual (PIRC, 0x1F)))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (0x09)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRS1) /* \_SB_.PRS1 */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                INTC (0x1F)
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (BUFA, One, IRQX)
                ShiftLeft (One, PIRC, IRQX) /* \_SB_.LNKC._CRS.IRQX */
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Decrement (Local0)
                Store (Local0, PIRC) /* \_SB_.PIRC */
            }
        }

        Device (LNKD)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (LAnd (PIRD, LNotEqual (PIRD, 0x1F)))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (0x09)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRS1) /* \_SB_.PRS1 */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                INTD (0x1F)
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (BUFA, One, IRQX)
                ShiftLeft (One, PIRD, IRQX) /* \_SB_.LNKD._CRS.IRQX */
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Decrement (Local0)
                Store (Local0, PIRD) /* \_SB_.PIRD */
            }
        }

        Device (LNKE)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x05)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (LAnd (PIRE, LNotEqual (PIRE, 0x1F)))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (0x09)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRS1) /* \_SB_.PRS1 */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                Store (0x1F, PIRE) /* \_SB_.PIRE */
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (BUFA, One, IRQX)
                ShiftLeft (One, PIRE, IRQX) /* \_SB_.LNKE._CRS.IRQX */
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Decrement (Local0)
                Store (Local0, PIRE) /* \_SB_.PIRE */
            }
        }

        Device (LNKF)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x06)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (LAnd (PIRF, LNotEqual (PIRF, 0x1F)))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (0x09)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRS1) /* \_SB_.PRS1 */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                Store (0x1F, PIRF) /* \_SB_.PIRF */
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (BUFA, One, IRQX)
                ShiftLeft (One, PIRF, IRQX) /* \_SB_.LNKF._CRS.IRQX */
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Decrement (Local0)
                Store (Local0, PIRF) /* \_SB_.PIRF */
            }
        }

        Device (LNKG)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x07)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (LAnd (PIRG, LNotEqual (PIRG, 0x1F)))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (0x09)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRS1) /* \_SB_.PRS1 */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                Store (0x1F, PIRG) /* \_SB_.PIRG */
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (BUFA, One, IRQX)
                ShiftLeft (One, PIRG, IRQX) /* \_SB_.LNKG._CRS.IRQX */
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Decrement (Local0)
                Store (Local0, PIRG) /* \_SB_.PIRG */
            }
        }

        Device (LNKH)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x08)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (LAnd (PIRH, LNotEqual (PIRH, 0x1F)))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (0x09)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRS1) /* \_SB_.PRS1 */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                Store (0x1F, PIRH) /* \_SB_.PIRH */
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (BUFA, One, IRQX)
                ShiftLeft (One, PIRH, IRQX) /* \_SB_.LNKH._CRS.IRQX */
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Decrement (Local0)
                Store (Local0, PIRH) /* \_SB_.PIRH */
            }
        }

        Method (GSMI, 1, NotSerialized)
        {
            Store (Arg0, APMD) /* \APMD */
            Store (0xE4, APMC) /* \APMC */
            Sleep (0x02)
        }

        Method (S80H, 1, NotSerialized)
        {
            Store (Arg0, P80H) /* \P80H */
        }

        Method (BSMI, 1, NotSerialized)
        {
            Store (Arg0, APMD) /* \APMD */
            Store (0xBE, APMC) /* \APMC */
            Sleep (One)
        }

        Device (ADP1)
        {
            Name (_HID, "ACPI0003" /* Power Source Device */)  // _HID: Hardware ID
            Name (_PCL, Package (0x01)  // _PCL: Power Consumer List
            {
                _SB
            })
            Name (XX00, Buffer (0x03) {})
            Name (ACRT, Zero)
            Method (_PSR, 0, NotSerialized)  // _PSR: Power Source
            {
                CreateWordField (XX00, Zero, SSZE)
                CreateByteField (XX00, 0x02, OCST)
                Store (0x03, SSZE) /* \_SB_.ADP1._PSR.SSZE */
                Store (^^PCI0.LPC0.EC0.ACDC, Local0)
                If (Local0)
                {
                    AFN4 (One)
                    Store (Zero, OCST) /* \_SB_.ADP1._PSR.OCST */
                }
                Else
                {
                    AFN4 (0x02)
                    Store (One, OCST) /* \_SB_.ADP1._PSR.OCST */
                }

                ALIB (One, XX00)
                Store (Zero, ACRT) /* \_SB_.ADP1.ACRT */
                Return (^^PCI0.LPC0.EC0.ACDC) /* \_SB_.PCI0.LPC0.EC0_.ACDC */
            }

            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                0x1C, 
                0x03
            })
        }

        Device (BAT1)
        {
            Name (_HID, EisaId ("PNP0C0A") /* Control Method Battery */)  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Method (_PCL, 0, NotSerialized)  // _PCL: Power Consumer List
            {
                Return (_SB) /* \_SB_ */
            }

            Name (BATP, 0x0F)
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (BATP) /* \_SB_.BAT1.BATP */
            }

            Name (PBIX, Package (0x14)
            {
                Zero, 
                One, 
                Ones, 
                Ones, 
                One, 
                Ones, 
                0x64, 
                0x32, 
                Zero, 
                0x00017318, 
                Ones, 
                Ones, 
                0x88B8, 
                0x61A8, 
                One, 
                One, 
                "BAT1", 
                " ", 
                " ", 
                " "
            })
            Method (_BIX, 0, NotSerialized)  // _BIX: Battery Information Extended
            {
                If (^^PCI0.LPC0.ECOK ())
                {
                    If (UPBX ())
                    {
                        Store (Ones, Index (PBIX, 0x02))
                        Store (Ones, Index (PBIX, 0x03))
                        Store (Ones, Index (PBIX, 0x05))
                        Store (Zero, Index (PBIX, 0x08))
                        Store ("Bad", Index (PBIX, 0x10))
                        Store ("Bad", Index (PBIX, 0x11))
                        Store ("Bad", Index (PBIX, 0x12))
                        Store ("Bad", Index (PBIX, 0x13))
                    }
                }

                Return (PBIX) /* \_SB_.BAT1.PBIX */
            }

            Method (UPBX, 0, NotSerialized)
            {
                If (LEqual (And (^^PCI0.LPC0.EC0.BATL, One), Zero))
                {
                    Return (0xFF)
                }

                Store (^^PCI0.LPC0.EC0.BTAP, Index (PBIX, 0x02))
                Name (FDDC, Zero)
                Multiply (Divide (^^PCI0.LPC0.EC0.BTAP, 0x0A, ), 0x0B, FDDC) /* \_SB_.BAT1.UPBX.FDDC */
                If (LGreaterEqual (^^PCI0.LPC0.EC0.BTFC, FDDC))
                {
                    Store (FDDC, Index (PBIX, 0x03))
                }
                Else
                {
                    Store (^^PCI0.LPC0.EC0.BTFC, Index (PBIX, 0x03))
                }

                Store (^^PCI0.LPC0.EC0.BTDV, Index (PBIX, 0x05))
                Store (^^PCI0.LPC0.EC0.BTCC, Index (PBIX, 0x08))
                Store (^^PCI0.LPC0.EC0.BDNA, Local0)
                PBFE (Local0, ^^PCI0.LPC0.EC0.BDBC, Zero)
                Store (Local0, Index (PBIX, 0x10))
                Store (ITOS (ToBCD (^^PCI0.LPC0.EC0.BTSN)), Index (PBIX, 0x11))
                If (^^PCI0.LPC0.EC0.CHEM)
                {
                    Store ("NiMH", Index (PBIX, 0x12))
                }
                Else
                {
                    Store ("LIon", Index (PBIX, 0x12))
                }

                Store (^^PCI0.LPC0.EC0.BNAM, Local0)
                PBFE (Local0, ^^PCI0.LPC0.EC0.BNBC, Zero)
                Store (Local0, Index (PBIX, 0x13))
                Return (Zero)
            }

            Name (PBIF, Package (0x0D)
            {
                One, 
                Ones, 
                Ones, 
                One, 
                Ones, 
                0x64, 
                0x32, 
                One, 
                One, 
                "BAT1", 
                " ", 
                " ", 
                " "
            })
            Method (_BIF, 0, NotSerialized)  // _BIF: Battery Information
            {
                If (^^PCI0.LPC0.ECOK ())
                {
                    If (UPBI ())
                    {
                        Store (Ones, Index (PBIF, One))
                        Store (Ones, Index (PBIF, 0x02))
                        Store (Ones, Index (PBIF, 0x04))
                        Store ("Bad", Index (PBIF, 0x09))
                        Store ("Bad", Index (PBIF, 0x0A))
                        Store ("Bad", Index (PBIF, 0x0B))
                        Store ("Bad", Index (PBIF, 0x0C))
                    }
                }

                Return (PBIF) /* \_SB_.BAT1.PBIF */
            }

            Method (UPBI, 0, NotSerialized)
            {
                If (LEqual (And (^^PCI0.LPC0.EC0.BATL, One), Zero))
                {
                    Return (0xFF)
                }

                Store (^^PCI0.LPC0.EC0.BTAP, Index (PBIF, One))
                Store (^^PCI0.LPC0.EC0.BTFC, Index (PBIF, 0x02))
                Store (^^PCI0.LPC0.EC0.BTDV, Index (PBIF, 0x04))
                Store (^^PCI0.LPC0.EC0.BDNA, Local0)
                PBFE (Local0, ^^PCI0.LPC0.EC0.BDBC, Zero)
                Store (Local0, Index (PBIF, 0x09))
                Store (ITOS (ToBCD (^^PCI0.LPC0.EC0.BTSN)), Index (PBIF, 0x0A))
                If (^^PCI0.LPC0.EC0.CHEM)
                {
                    Store ("NiMH", Index (PBIF, 0x0B))
                }
                Else
                {
                    Store ("LIon", Index (PBIF, 0x0B))
                }

                Store (^^PCI0.LPC0.EC0.BNAM, Local0)
                PBFE (Local0, ^^PCI0.LPC0.EC0.BNBC, Zero)
                Store (Local0, Index (PBIF, 0x0C))
                Return (Zero)
            }

            Name (PBST, Package (0x04)
            {
                Zero, 
                Ones, 
                Ones, 
                0x03E8
            })
            Method (_BST, 0, NotSerialized)  // _BST: Battery Status
            {
                If (^^PCI0.LPC0.ECOK ())
                {
                    If (UPBS ())
                    {
                        Store (Zero, Index (PBST, Zero))
                        Store (Ones, Index (PBST, One))
                        Store (Ones, Index (PBST, 0x02))
                        Store (0x03E8, Index (PBST, 0x03))
                    }
                }

                Return (PBST) /* \_SB_.BAT1.PBST */
            }

            Method (UPBS, 0, NotSerialized)
            {
                If (LEqual (And (^^PCI0.LPC0.EC0.BATL, One), Zero))
                {
                    Return (0xFF)
                }

                Store (Zero, Local0)
                If (LEqual (And (^^PCI0.LPC0.EC0.BATH, 0x0F), One))
                {
                    Or (Local0, One, Local0)
                }
                Else
                {
                    If (And (^^PCI0.LPC0.EC0.BATH, 0x0C))
                    {
                        Or (Local0, 0x02, Local0)
                    }
                }

                Store (Local0, Index (PBST, Zero))
                Store (^^PCI0.LPC0.EC0.BT1I, Local1)
                If (And (Local1, 0x8000))
                {
                    Or (Local1, 0xFFFF0000, Local1)
                    Add (Subtract (Ones, Local1), One, Local1)
                }

                Store (Local1, Index (PBST, One))
                Store (^^PCI0.LPC0.EC0.BT1C, Index (PBST, 0x02))
                Store (^^PCI0.LPC0.EC0.BT1V, Index (PBST, 0x03))
                Return (Zero)
            }

            Method (GBFE, 3, NotSerialized)
            {
                CreateByteField (Arg0, Arg1, TIDX)
                Store (TIDX, Arg2)
            }

            Method (PBFE, 3, NotSerialized)
            {
                CreateByteField (Arg0, Arg1, TIDX)
                Store (Arg2, TIDX) /* \_SB_.BAT1.PBFE.TIDX */
            }

            Method (ITOS, 1, NotSerialized)
            {
                Store (Buffer (0x09)
                    {
                        /* 0000 */  0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  /* 0....... */
                        /* 0008 */  0x00                                             /* . */
                    }, Local0)
                Store (Buffer (0x11)
                    {
                        "0123456789ABCDEF"
                    }, Local7)
                Store (0x08, Local1)
                Store (Zero, Local2)
                Store (Zero, Local3)
                While (Local1)
                {
                    Decrement (Local1)
                    And (ShiftRight (Arg0, ShiftLeft (Local1, 0x02)), 0x0F, Local4)
                    If (Local4)
                    {
                        Store (Ones, Local3)
                    }

                    If (Local3)
                    {
                        GBFE (Local7, Local4, RefOf (Local5))
                        PBFE (Local0, Local2, Local5)
                        Increment (Local2)
                    }
                }

                Return (Local0)
            }
        }

        Device (LID0)
        {
            Name (_HID, EisaId ("PNP0C0D") /* Lid Device */)  // _HID: Hardware ID
            Method (_LID, 0, NotSerialized)  // _LID: Lid Status
            {
                If (^^PCI0.LPC0.ECOK ())
                {
                    If (^^PCI0.LPC0.EC0.LSTE)
                    {
                        Return (Zero)
                    }
                    Else
                    {
                        Return (One)
                    }
                }

                Return (One)
            }
        }
    }

    Name (TSOS, 0x75)
    If (CondRefOf (\_OSI))
    {
        If (_OSI ("Windows 2009"))
        {
            Store (0x50, TSOS) /* \TSOS */
        }

        If (_OSI ("Windows 2015"))
        {
            Store (0x70, TSOS) /* \TSOS */
        }

        If (_OSI ("Linux"))
        {
            Store (0x80, TSOS) /* \TSOS */
        }
    }

    Scope (_SB)
    {
        OperationRegion (SMIC, SystemMemory, 0xFED80000, 0x00800000)
        Field (SMIC, ByteAcc, NoLock, Preserve)
        {
            Offset (0x36A), 
            SMIB,   8
        }

        OperationRegion (SSMI, SystemIO, SMIB, 0x02)
        Field (SSMI, AnyAcc, NoLock, Preserve)
        {
            SMIW,   16
        }

        OperationRegion (ECMC, SystemIO, 0x72, 0x02)
        Field (ECMC, AnyAcc, NoLock, Preserve)
        {
            ECMI,   8, 
            ECMD,   8
        }

        IndexField (ECMI, ECMD, ByteAcc, NoLock, Preserve)
        {
            Offset (0x08), 
            FRTB,   32
        }

        OperationRegion (FRTP, SystemMemory, FRTB, 0x0100)
        Field (FRTP, AnyAcc, NoLock, Preserve)
        {
            PEBA,   32, 
                ,   5, 
            IC0E,   1, 
            IC1E,   1, 
            IC2E,   1, 
            IC3E,   1, 
            IC4E,   1, 
            IC5E,   1, 
            UT0E,   1, 
            UT1E,   1, 
                ,   1, 
                ,   1, 
            ST_E,   1, 
            UT2E,   1, 
                ,   1, 
            EMMD,   2, 
                ,   3, 
            XHCE,   1, 
                ,   1, 
                ,   1, 
            UT3E,   1, 
            ESPI,   1, 
            EMME,   1, 
            Offset (0x08), 
            PCEF,   1, 
                ,   4, 
            IC0D,   1, 
            IC1D,   1, 
            IC2D,   1, 
            IC3D,   1, 
            IC4D,   1, 
            IC5D,   1, 
            UT0D,   1, 
            UT1D,   1, 
                ,   1, 
                ,   1, 
            ST_D,   1, 
            UT2D,   1, 
                ,   1, 
            EHCD,   1, 
                ,   4, 
            XHCD,   1, 
            SD_D,   1, 
                ,   1, 
            UT3D,   1, 
                ,   1, 
            EMD3,   1, 
                ,   2, 
            S03D,   1, 
            FW00,   16, 
            FW01,   32, 
            FW02,   16, 
            FW03,   32, 
            SDS0,   8, 
            SDS1,   8, 
            CZFG,   1, 
            Offset (0x20), 
            SD10,   32, 
            EH10,   32, 
            XH10,   32, 
            STBA,   32
        }

        OperationRegion (FCFG, SystemMemory, PEBA, 0x01000000)
        Field (FCFG, DWordAcc, NoLock, Preserve)
        {
            Offset (0xA3044), 
            IPDE,   32, 
            IMPE,   32, 
            Offset (0xA3078), 
                ,   2, 
            LDQ0,   1, 
            Offset (0xA30CB), 
                ,   7, 
            AUSS,   1, 
            Offset (0xA30D0), 
                ,   13, 
            LCLK,   2
        }

        OperationRegion (IOMX, SystemMemory, 0xFED80D00, 0x0100)
        Field (IOMX, AnyAcc, NoLock, Preserve)
        {
            Offset (0x15), 
            IM15,   8, 
            IM16,   8, 
            Offset (0x1F), 
            IM1F,   8, 
            IM20,   8, 
            Offset (0x44), 
            IM44,   8, 
            Offset (0x46), 
            IM46,   8, 
            Offset (0x4A), 
            IM4A,   8, 
            IM4B,   8, 
            Offset (0x57), 
            IM57,   8, 
            IM58,   8, 
            Offset (0x68), 
            IM68,   8, 
            IM69,   8, 
            IM6A,   8, 
            IM6B,   8, 
            Offset (0x6D), 
            IM6D,   8
        }

        OperationRegion (FMIS, SystemMemory, 0xFED80E00, 0x0100)
        Field (FMIS, AnyAcc, NoLock, Preserve)
        {
            Offset (0x40), 
                ,   13, 
            I24M,   1
        }

        OperationRegion (FGIO, SystemMemory, 0xFED81500, 0x0300)
        Field (FGIO, AnyAcc, NoLock, Preserve)
        {
            Offset (0xA8), 
                ,   22, 
            O042,   1, 
            Offset (0x164), 
                ,   22, 
            O089,   1
        }

        OperationRegion (FACR, SystemMemory, 0xFED81E00, 0x0100)
        Field (FACR, AnyAcc, NoLock, Preserve)
        {
            Offset (0x80), 
                ,   28, 
            RD28,   1, 
                ,   1, 
            RQTY,   1, 
            Offset (0x84), 
                ,   28, 
            SD28,   1, 
                ,   1, 
            Offset (0xA0), 
            PG1A,   1
        }

        OperationRegion (EMMX, SystemMemory, 0xFEDD5800, 0x0130)
        Field (EMMX, AnyAcc, NoLock, Preserve)
        {
            Offset (0xD0), 
                ,   17, 
            FC18,   1, 
            FC33,   1, 
                ,   7, 
            CD_T,   1, 
            WP_T,   1
        }

        OperationRegion (EMMB, SystemMemory, 0xFEDD5800, 0x0130)
        Field (EMMB, AnyAcc, NoLock, Preserve)
        {
            Offset (0xA4), 
            E0A4,   32, 
            E0A8,   32, 
            Offset (0xB0), 
            E0B0,   32, 
            Offset (0xD0), 
            E0D0,   32, 
            Offset (0x116), 
            E116,   32
        }

        Name (SVBF, Buffer (0x0100)
        {
             0x00                                             /* . */
        })
        CreateDWordField (SVBF, Zero, S0A4)
        CreateDWordField (SVBF, 0x04, S0A8)
        CreateDWordField (SVBF, 0x08, S0B0)
        CreateDWordField (SVBF, 0x0C, S0D0)
        CreateDWordField (SVBF, 0x10, S116)
        Method (SECR, 0, Serialized)
        {
            Store (E116, S116) /* \_SB_.S116 */
            Store (Zero, RQTY) /* \_SB_.RQTY */
            Store (One, RD28) /* \_SB_.RD28 */
            Store (SD28, Local0)
            While (Local0)
            {
                Store (SD28, Local0)
            }
        }

        Method (RECR, 0, Serialized)
        {
            Store (S116, E116) /* \_SB_.E116 */
        }

        OperationRegion (LUIE, SystemMemory, 0xFEDC0020, 0x04)
        Field (LUIE, AnyAcc, NoLock, Preserve)
        {
            IER0,   1, 
            IER1,   1, 
            IER2,   1, 
            IER3,   1, 
            UOL0,   1, 
            UOL1,   1, 
            UOL2,   1, 
            UOL3,   1, 
            WUR0,   2, 
            WUR1,   2, 
            WUR2,   2, 
            WUR3,   2
        }

        Method (FRUI, 1, Serialized)
        {
            If (LEqual (Arg0, Zero))
            {
                Return (IUA0) /* \_SB_.IUA0 */
            }

            If (LEqual (Arg0, One))
            {
                Return (IUA1) /* \_SB_.IUA1 */
            }

            If (LEqual (Arg0, 0x02))
            {
                Return (IUA2) /* \_SB_.IUA2 */
            }

            If (LEqual (Arg0, 0x03))
            {
                Return (IUA3) /* \_SB_.IUA3 */
            }
        }

        Method (SRAD, 2, Serialized)
        {
            ShiftLeft (Arg0, One, Local0)
            Add (Local0, 0xFED81E40, Local0)
            OperationRegion (ADCR, SystemMemory, Local0, 0x02)
            Field (ADCR, ByteAcc, NoLock, Preserve)
            {
                ADTD,   2, 
                ADPS,   1, 
                ADPD,   1, 
                ADSO,   1, 
                ADSC,   1, 
                ADSR,   1, 
                ADIS,   1, 
                ADDS,   3
            }

            Store (One, ADIS) /* \_SB_.SRAD.ADIS */
            Store (Zero, ADSR) /* \_SB_.SRAD.ADSR */
            Stall (Arg1)
            Store (One, ADSR) /* \_SB_.SRAD.ADSR */
            Store (Zero, ADIS) /* \_SB_.SRAD.ADIS */
            Stall (Arg1)
        }

        Method (DSAD, 2, Serialized)
        {
            ShiftLeft (Arg0, One, Local0)
            Add (Local0, 0xFED81E40, Local0)
            OperationRegion (ADCR, SystemMemory, Local0, 0x02)
            Field (ADCR, ByteAcc, NoLock, Preserve)
            {
                ADTD,   2, 
                ADPS,   1, 
                ADPD,   1, 
                ADSO,   1, 
                ADSC,   1, 
                ADSR,   1, 
                ADIS,   1, 
                ADDS,   3
            }

            If (LNotEqual (Arg1, ADTD))
            {
                If (LEqual (Arg1, Zero))
                {
                    Store (Zero, ADTD) /* \_SB_.DSAD.ADTD */
                    Store (One, ADPD) /* \_SB_.DSAD.ADPD */
                    Store (ADDS, Local0)
                    While (LNotEqual (Local0, 0x07))
                    {
                        Store (ADDS, Local0)
                    }
                }

                If (LEqual (Arg1, 0x03))
                {
                    Store (Zero, ADPD) /* \_SB_.DSAD.ADPD */
                    Store (ADDS, Local0)
                    While (LNotEqual (Local0, Zero))
                    {
                        Store (ADDS, Local0)
                    }

                    Store (0x03, ADTD) /* \_SB_.DSAD.ADTD */
                }
            }
        }

        Method (HSAD, 2, Serialized)
        {
            ShiftLeft (One, Arg0, Local3)
            ShiftLeft (Arg0, One, Local0)
            Add (Local0, 0xFED81E40, Local0)
            OperationRegion (ADCR, SystemMemory, Local0, 0x02)
            Field (ADCR, ByteAcc, NoLock, Preserve)
            {
                ADTD,   2, 
                ADPS,   1, 
                ADPD,   1, 
                ADSO,   1, 
                ADSC,   1, 
                ADSR,   1, 
                ADIS,   1, 
                ADDS,   3
            }

            If (LNotEqual (Arg1, ADTD))
            {
                If (LEqual (Arg1, Zero))
                {
                    Store (Zero, ADTD) /* \_SB_.HSAD.ADTD */
                    Store (One, ADPD) /* \_SB_.HSAD.ADPD */
                    Store (ADDS, Local0)
                    While (LNotEqual (Local0, 0x07))
                    {
                        Store (ADDS, Local0)
                    }

                    Store (One, RQTY) /* \_SB_.RQTY */
                    Store (One, RD28) /* \_SB_.RD28 */
                    Store (SD28, Local0)
                    While (LNot (Local0))
                    {
                        Store (SD28, Local0)
                    }
                }

                If (LEqual (Arg1, 0x03))
                {
                    Store (Zero, RQTY) /* \_SB_.RQTY */
                    Store (One, RD28) /* \_SB_.RD28 */
                    Store (SD28, Local0)
                    While (Local0)
                    {
                        Store (SD28, Local0)
                    }

                    Store (Zero, ADPD) /* \_SB_.HSAD.ADPD */
                    Store (ADDS, Local0)
                    While (LNotEqual (Local0, Zero))
                    {
                        Store (ADDS, Local0)
                    }

                    Store (0x03, ADTD) /* \_SB_.HSAD.ADTD */
                }
            }
        }

        OperationRegion (FPIC, SystemIO, 0x0C00, 0x02)
        Field (FPIC, AnyAcc, NoLock, Preserve)
        {
            FPII,   8, 
            FPID,   8
        }

        IndexField (FPII, FPID, ByteAcc, NoLock, Preserve)
        {
            Offset (0xF4), 
            IUA0,   8, 
            IUA1,   8, 
            Offset (0xF8), 
            IUA2,   8, 
            IUA3,   8
        }

        Device (GPIO)
        {
            Name (_HID, "AMDI0030")  // _HID: Hardware ID
            Name (_CID, "AMDI0030")  // _CID: Compatible ID
            Name (_UID, Zero)  // _UID: Unique ID
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Name (RBUF, ResourceTemplate ()
                {
                    Interrupt (ResourceConsumer, Level, ActiveLow, Shared, ,, )
                    {
                        0x00000007,
                    }
                    Memory32Fixed (ReadWrite,
                        0xFED81500,         // Address Base
                        0x00000400,         // Address Length
                        )
                })
                Return (RBUF) /* \_SB_.GPIO._CRS.RBUF */
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (LGreaterEqual (TSOS, 0x70))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }

        Device (FUR0)
        {
            Name (_HID, "AMDI0020")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IRQ (Edge, ActiveHigh, Exclusive, )
                    {3}
                Memory32Fixed (ReadWrite,
                    0xFEDC9000,         // Address Base
                    0x00001000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0xFEDC7000,         // Address Base
                    0x00001000,         // Address Length
                    )
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (LGreaterEqual (TSOS, 0x70))
                {
                    If (LEqual (UT0E, One))
                    {
                        If (UOL0)
                        {
                            Return (Zero)
                        }

                        Return (0x0F)
                    }

                    Return (Zero)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_S0W, 0, NotSerialized)  // _S0W: S0 Device Wake State
            {
                If (LAnd (UT0D, UT0E))
                {
                    Return (0x04)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
            {
                If (LAnd (UT0D, UT0E))
                {
                    DSAD (0x0B, Zero)
                }
            }

            Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
            {
                If (LAnd (UT0D, UT0E))
                {
                    DSAD (0x0B, 0x03)
                }
            }
        }

        Device (FUR1)
        {
            Name (_HID, "AMDI0020")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IRQ (Edge, ActiveHigh, Exclusive, )
                    {4}
                Memory32Fixed (ReadWrite,
                    0xFEDCA000,         // Address Base
                    0x00001000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0xFEDC8000,         // Address Base
                    0x00001000,         // Address Length
                    )
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (LGreaterEqual (TSOS, 0x70))
                {
                    If (LEqual (UT1E, One))
                    {
                        If (UOL1)
                        {
                            Return (Zero)
                        }

                        Return (0x0F)
                    }

                    Return (Zero)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_S0W, 0, NotSerialized)  // _S0W: S0 Device Wake State
            {
                If (LAnd (UT1D, UT1E))
                {
                    Return (0x04)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
            {
                If (LAnd (UT1D, UT1E))
                {
                    DSAD (0x0C, Zero)
                }
            }

            Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
            {
                If (LAnd (UT1D, UT1E))
                {
                    DSAD (0x0C, 0x03)
                }
            }
        }

        Device (FUR2)
        {
            Name (_HID, "AMDI0020")  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IRQ (Edge, ActiveHigh, Exclusive, )
                    {15}
                Memory32Fixed (ReadWrite,
                    0xFEDCE000,         // Address Base
                    0x00001000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0xFEDCC000,         // Address Base
                    0x00001000,         // Address Length
                    )
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (LGreaterEqual (TSOS, 0x70))
                {
                    If (LEqual (UT2E, One))
                    {
                        If (UOL2)
                        {
                            Return (Zero)
                        }

                        Return (0x0F)
                    }

                    Return (Zero)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_S0W, 0, NotSerialized)  // _S0W: S0 Device Wake State
            {
                If (LAnd (UT2D, UT2E))
                {
                    Return (0x04)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
            {
                If (LAnd (UT2D, UT2E))
                {
                    DSAD (0x10, Zero)
                }
            }

            Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
            {
                If (LAnd (UT2D, UT2E))
                {
                    DSAD (0x10, 0x03)
                }
            }
        }

        Device (FUR3)
        {
            Name (_HID, "AMDI0020")  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IRQ (Edge, ActiveHigh, Exclusive, )
                    {5}
                Memory32Fixed (ReadWrite,
                    0xFEDCF000,         // Address Base
                    0x00001000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0xFEDCD000,         // Address Base
                    0x00001000,         // Address Length
                    )
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (LGreaterEqual (TSOS, 0x70))
                {
                    If (LEqual (UT3E, One))
                    {
                        If (UOL3)
                        {
                            Return (Zero)
                        }

                        Return (0x0F)
                    }

                    Return (Zero)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_S0W, 0, NotSerialized)  // _S0W: S0 Device Wake State
            {
                If (LAnd (UT3D, UT3E))
                {
                    Return (0x04)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
            {
                If (LAnd (UT3D, UT3E))
                {
                    DSAD (0x1A, Zero)
                }
            }

            Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
            {
                If (LAnd (UT3D, UT3E))
                {
                    DSAD (0x1A, 0x03)
                }
            }
        }

        Device (I2CA)
        {
            Name (_HID, "AMDI0011")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_ADR, Zero)  // _ADR: Address
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IRQ (Edge, ActiveHigh, Exclusive, )
                    {10}
                Memory32Fixed (ReadWrite,
                    0xFEDC2000,         // Address Base
                    0x00001000,         // Address Length
                    )
            })
            Name (_DEP, Package (0x01)  // _DEP: Dependencies
            {
                ^PCI0.GP17.MP2C
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (LGreaterEqual (TSOS, 0x70))
                {
                    If (LEqual (IC0E, One))
                    {
                        Return (0x0F)
                    }

                    Return (Zero)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (RSET, 0, NotSerialized)
            {
                SRAD (0x05, 0xC8)
            }
        }

        Device (I2CB)
        {
            Name (_HID, "AMDI0011")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_ADR, One)  // _ADR: Address
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IRQ (Edge, ActiveHigh, Exclusive, )
                    {11}
                Memory32Fixed (ReadWrite,
                    0xFEDC3000,         // Address Base
                    0x00001000,         // Address Length
                    )
            })
            Name (_DEP, Package (0x01)  // _DEP: Dependencies
            {
                ^PCI0.GP17.MP2C
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (LGreaterEqual (TSOS, 0x70))
                {
                    If (LEqual (IC1E, One))
                    {
                        Return (0x0F)
                    }

                    Return (Zero)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (RSET, 0, NotSerialized)
            {
                SRAD (0x06, 0xC8)
            }
        }

        Device (I2CC)
        {
            Name (_HID, "AMDI0010")  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IRQ (Edge, ActiveHigh, Exclusive, )
                    {14}
                Memory32Fixed (ReadWrite,
                    0xFEDC4000,         // Address Base
                    0x00001000,         // Address Length
                    )
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (LGreaterEqual (TSOS, 0x70))
                {
                    If (LEqual (IC2E, One))
                    {
                        Return (0x0F)
                    }

                    Return (Zero)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (RSET, 0, NotSerialized)
            {
                SRAD (0x07, 0xC8)
            }

            Method (_S0W, 0, NotSerialized)  // _S0W: S0 Device Wake State
            {
                If (LAnd (IC2D, IC2E))
                {
                    Return (0x04)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
            {
                If (LAnd (IC2D, IC2E))
                {
                    DSAD (0x07, Zero)
                }
            }

            Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
            {
                If (LAnd (IC2D, IC2E))
                {
                    DSAD (0x07, 0x03)
                }
            }
        }

        Device (I2CD)
        {
            Name (_HID, "AMDI0010")  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IRQ (Edge, ActiveHigh, Exclusive, )
                    {6}
                Memory32Fixed (ReadWrite,
                    0xFEDC5000,         // Address Base
                    0x00001000,         // Address Length
                    )
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (LGreaterEqual (TSOS, 0x70))
                {
                    If (LEqual (IC3E, One))
                    {
                        Return (0x0F)
                    }

                    Return (Zero)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (RSET, 0, NotSerialized)
            {
                SRAD (0x08, 0xC8)
            }

            Method (_S0W, 0, NotSerialized)  // _S0W: S0 Device Wake State
            {
                If (LAnd (IC3D, IC3E))
                {
                    Return (0x04)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
            {
                If (LAnd (IC3D, IC3E))
                {
                    DSAD (0x08, Zero)
                }
            }

            Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
            {
                If (LAnd (IC3D, IC3E))
                {
                    DSAD (0x08, 0x03)
                }
            }
        }

        Device (I2CE)
        {
            Name (_HID, "AMDI0010")  // _HID: Hardware ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IRQ (Edge, ActiveHigh, Exclusive, )
                    {14}
                Memory32Fixed (ReadWrite,
                    0xFEDC6000,         // Address Base
                    0x00001000,         // Address Length
                    )
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (LGreaterEqual (TSOS, 0x70))
                {
                    If (LEqual (IC4E, One))
                    {
                        Return (0x0F)
                    }

                    Return (Zero)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (RSET, 0, NotSerialized)
            {
                SRAD (0x09, 0xC8)
            }
        }

        Device (I2CF)
        {
            Name (_HID, "AMDI0010")  // _HID: Hardware ID
            Name (_UID, 0x05)  // _UID: Unique ID
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IRQ (Edge, ActiveHigh, Exclusive, )
                    {15}
                Memory32Fixed (ReadWrite,
                    0xFEDCB000,         // Address Base
                    0x00001000,         // Address Length
                    )
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (LGreaterEqual (TSOS, 0x70))
                {
                    If (LEqual (IC5E, One))
                    {
                        Return (0x0F)
                    }

                    Return (Zero)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (RSET, 0, NotSerialized)
            {
                SRAD (0x0A, 0xC8)
            }
        }

        Method (EPIN, 0, NotSerialized)
        {
            Store (Zero, IPDE) /* \_SB_.IPDE */
            Store (0xFF00, IMPE) /* \_SB_.IMPE */
            Store (One, IM15) /* \_SB_.IM15 */
            Store (One, IM16) /* \_SB_.IM16 */
            Store (One, IM20) /* \_SB_.IM20 */
            Store (One, IM44) /* \_SB_.IM44 */
            Store (One, IM46) /* \_SB_.IM46 */
            Store (One, IM68) /* \_SB_.IM68 */
            Store (One, IM69) /* \_SB_.IM69 */
            Store (One, IM6A) /* \_SB_.IM6A */
            Store (One, IM6B) /* \_SB_.IM6B */
            Store (One, IM4A) /* \_SB_.IM4A */
            Store (One, IM58) /* \_SB_.IM58 */
            Store (One, IM4B) /* \_SB_.IM4B */
            Store (One, IM57) /* \_SB_.IM57 */
            Store (One, IM6D) /* \_SB_.IM6D */
            Store (One, IM1F) /* \_SB_.IM1F */
            SECR ()
        }

        Name (NCRS, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {5}
            Memory32Fixed (ReadWrite,
                0xFEDD5000,         // Address Base
                0x00001000,         // Address Length
                )
        })
        Name (DCRS, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {5}
            Memory32Fixed (ReadWrite,
                0xFEDD5000,         // Address Base
                0x00001000,         // Address Length
                )
            GpioInt (Edge, ActiveBoth, SharedAndWake, PullUp, 0x0BB8,
                "\\_SB.GPIO", 0x00, ResourceConsumer, ,
                )
                {   // Pin list
                    0x0044
                }
            GpioIo (Shared, PullUp, 0x0000, 0x0000, IoRestrictionNone,
                "\\_SB.GPIO", 0x00, ResourceConsumer, ,
                )
                {   // Pin list
                    0x0044
                }
        })
        Name (AHID, "AMDI0040")
        Name (ACID, "AMDI0040")
        Name (MHID, "AMDI0041")
        Name (MCID, "AMDI0041")
        Name (SHID, 0x400DD041)
        Name (SCID, "PCICC_080501")
        Device (EMM0)
        {
            Method (_HID, 0, Serialized)  // _HID: Hardware ID
            {
                If (LEqual (EMMD, Zero))
                {
                    Return (AHID) /* \_SB_.AHID */
                }

                If (LEqual (EMMD, One))
                {
                    Return (SHID) /* \_SB_.SHID */
                }

                If (LEqual (EMMD, 0x02))
                {
                    Return (MHID) /* \_SB_.MHID */
                }
            }

            Method (_CID, 0, Serialized)  // _CID: Compatible ID
            {
                If (LEqual (EMMD, Zero))
                {
                    Return (ACID) /* \_SB_.ACID */
                }

                If (LEqual (EMMD, One))
                {
                    Return (SCID) /* \_SB_.SCID */
                }

                If (LEqual (EMMD, 0x02))
                {
                    Return (MCID) /* \_SB_.MCID */
                }
            }

            Name (_UID, Zero)  // _UID: Unique ID
            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                If (EMD3)
                {
                    Return (DCRS) /* \_SB_.DCRS */
                }
                Else
                {
                    Return (NCRS) /* \_SB_.NCRS */
                }
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (LGreaterEqual (TSOS, 0x70))
                {
                    If (EMME)
                    {
                        Return (0x0F)
                    }

                    Return (Zero)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_INI, 0, NotSerialized)  // _INI: Initialize
            {
                If (EMME)
                {
                    EPIN ()
                }
            }

            Method (_S0W, 0, NotSerialized)  // _S0W: S0 Device Wake State
            {
                If (LAnd (EMD3, EMME))
                {
                    Return (0x04)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
            {
                If (LAnd (EMD3, EMME))
                {
                    HSAD (0x1C, Zero)
                    RECR ()
                }
            }

            Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
            {
                If (LAnd (EMD3, EMME))
                {
                    HSAD (0x1C, 0x03)
                }
            }
        }

        Name (D0ST, One)
        Name (D3ST, One)
        PowerResource (P0ST, 0x00, 0x0000)
        {
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (D0ST) /* \_SB_.D0ST */
            }

            Method (_ON, 0, NotSerialized)  // _ON_: Power On
            {
                Store (One, D0ST) /* \_SB_.D0ST */
            }

            Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
            {
                Store (Zero, D0ST) /* \_SB_.D0ST */
            }
        }

        PowerResource (P3ST, 0x00, 0x0000)
        {
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (D3ST) /* \_SB_.D3ST */
            }

            Method (_ON, 0, NotSerialized)  // _ON_: Power On
            {
                Store (One, D3ST) /* \_SB_.D3ST */
            }

            Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
            {
                Store (Zero, D3ST) /* \_SB_.D3ST */
            }
        }
    }

    Scope (_SB.PCI0)
    {
        Device (UAR1)
        {
            Name (_HID, EisaId ("PNP0501") /* 16550A-compatible COM Serial Port */)  // _HID: Hardware ID
            Name (_DDN, "COM1")  // _DDN: DOS Device Name
            Name (_UID, One)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (IER0)
                {
                    Return (0x0F)
                }

                Return (Zero)
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Name (BUF0, ResourceTemplate ()
                {
                    IO (Decode16,
                        0x02E8,             // Range Minimum
                        0x02E8,             // Range Maximum
                        0x01,               // Alignment
                        0x08,               // Length
                        _Y09)
                    IRQNoFlags (_Y0A)
                        {3}
                })
                CreateByteField (BUF0, \_SB.PCI0.UAR1._CRS._Y09._MIN, IOLO)  // _MIN: Minimum Base Address
                CreateByteField (BUF0, 0x03, IOHI)
                CreateByteField (BUF0, \_SB.PCI0.UAR1._CRS._Y09._MAX, IORL)  // _MAX: Maximum Base Address
                CreateByteField (BUF0, 0x05, IORH)
                CreateWordField (BUF0, \_SB.PCI0.UAR1._CRS._Y0A._INT, IRQL)  // _INT: Interrupts
                ShiftLeft (One, FRUI (WUR0), IRQL) /* \_SB_.PCI0.UAR1._CRS.IRQL */
                Return (BUF0) /* \_SB_.PCI0.UAR1._CRS.BUF0 */
            }
        }

        Device (UAR2)
        {
            Name (_HID, EisaId ("PNP0501") /* 16550A-compatible COM Serial Port */)  // _HID: Hardware ID
            Name (_DDN, "COM2")  // _DDN: DOS Device Name
            Name (_UID, 0x02)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (IER1)
                {
                    Return (0x0F)
                }

                Return (Zero)
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Name (BUF0, ResourceTemplate ()
                {
                    IO (Decode16,
                        0x02F8,             // Range Minimum
                        0x02F8,             // Range Maximum
                        0x01,               // Alignment
                        0x08,               // Length
                        _Y0B)
                    IRQNoFlags (_Y0C)
                        {4}
                })
                CreateByteField (BUF0, \_SB.PCI0.UAR2._CRS._Y0B._MIN, IOLO)  // _MIN: Minimum Base Address
                CreateByteField (BUF0, 0x03, IOHI)
                CreateByteField (BUF0, \_SB.PCI0.UAR2._CRS._Y0B._MAX, IORL)  // _MAX: Maximum Base Address
                CreateByteField (BUF0, 0x05, IORH)
                CreateWordField (BUF0, \_SB.PCI0.UAR2._CRS._Y0C._INT, IRQL)  // _INT: Interrupts
                ShiftLeft (One, FRUI (WUR1), IRQL) /* \_SB_.PCI0.UAR2._CRS.IRQL */
                Return (BUF0) /* \_SB_.PCI0.UAR2._CRS.BUF0 */
            }
        }

        Device (UAR3)
        {
            Name (_HID, EisaId ("PNP0501") /* 16550A-compatible COM Serial Port */)  // _HID: Hardware ID
            Name (_DDN, "COM3")  // _DDN: DOS Device Name
            Name (_UID, 0x03)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (IER2)
                {
                    Return (0x0F)
                }

                Return (Zero)
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Name (BUF0, ResourceTemplate ()
                {
                    IO (Decode16,
                        0x03E8,             // Range Minimum
                        0x03E8,             // Range Maximum
                        0x01,               // Alignment
                        0x08,               // Length
                        _Y0D)
                    IRQNoFlags (_Y0E)
                        {3}
                })
                CreateByteField (BUF0, \_SB.PCI0.UAR3._CRS._Y0D._MIN, IOLO)  // _MIN: Minimum Base Address
                CreateByteField (BUF0, 0x03, IOHI)
                CreateByteField (BUF0, \_SB.PCI0.UAR3._CRS._Y0D._MAX, IORL)  // _MAX: Maximum Base Address
                CreateByteField (BUF0, 0x05, IORH)
                CreateWordField (BUF0, \_SB.PCI0.UAR3._CRS._Y0E._INT, IRQL)  // _INT: Interrupts
                ShiftLeft (One, FRUI (WUR2), IRQL) /* \_SB_.PCI0.UAR3._CRS.IRQL */
                Return (BUF0) /* \_SB_.PCI0.UAR3._CRS.BUF0 */
            }
        }

        Device (UAR4)
        {
            Name (_HID, EisaId ("PNP0501") /* 16550A-compatible COM Serial Port */)  // _HID: Hardware ID
            Name (_DDN, "COM4")  // _DDN: DOS Device Name
            Name (_UID, 0x04)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (IER3)
                {
                    Return (0x0F)
                }

                Return (Zero)
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Name (BUF0, ResourceTemplate ()
                {
                    IO (Decode16,
                        0x03F8,             // Range Minimum
                        0x03F8,             // Range Maximum
                        0x01,               // Alignment
                        0x08,               // Length
                        _Y0F)
                    IRQNoFlags (_Y10)
                        {4}
                })
                CreateByteField (BUF0, \_SB.PCI0.UAR4._CRS._Y0F._MIN, IOLO)  // _MIN: Minimum Base Address
                CreateByteField (BUF0, 0x03, IOHI)
                CreateByteField (BUF0, \_SB.PCI0.UAR4._CRS._Y0F._MAX, IORL)  // _MAX: Maximum Base Address
                CreateByteField (BUF0, 0x05, IORH)
                CreateWordField (BUF0, \_SB.PCI0.UAR4._CRS._Y10._INT, IRQL)  // _INT: Interrupts
                ShiftLeft (One, FRUI (WUR3), IRQL) /* \_SB_.PCI0.UAR4._CRS.IRQL */
                Return (BUF0) /* \_SB_.PCI0.UAR4._CRS.BUF0 */
            }
        }
    }

    Scope (_SB.PCI0.GP17.VGA)
    {
        Device (CAMF)
        {
            Name (_ADR, 0x1000)  // _ADR: Address
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (LEqual (O042, One))
                {
                    Return (0x0F)
                }

                Return (0x0B)
            }

            Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
            {
                Store (One, O042) /* \_SB_.O042 */
            }

            Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
            {
                Store (Zero, O042) /* \_SB_.O042 */
            }
        }

        Device (CAMR)
        {
            Name (_ADR, 0x2000)  // _ADR: Address
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (LEqual (O089, One))
                {
                    Return (0x0F)
                }

                Return (0x0B)
            }

            Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
            {
                Store (One, O089) /* \_SB_.O089 */
            }

            Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
            {
                Store (Zero, O089) /* \_SB_.O089 */
            }
        }

        Method (RCPU, 0, NotSerialized)
        {
            Store (One, O089) /* \_SB_.O089 */
        }

        Method (RCPD, 0, NotSerialized)
        {
            Store (Zero, O089) /* \_SB_.O089 */
        }

        Method (FCPU, 0, NotSerialized)
        {
            Store (One, O042) /* \_SB_.O042 */
        }

        Method (FCPD, 0, NotSerialized)
        {
            Store (Zero, O042) /* \_SB_.O042 */
        }

        Method (ICLE, 0, NotSerialized)
        {
            Store (Zero, I24M) /* \_SB_.I24M */
        }

        Method (ICLD, 0, NotSerialized)
        {
            Store (One, I24M) /* \_SB_.I24M */
        }
    }

    Scope (_SB.PCI0.GP18.SATA)
    {
        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            P0ST
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            P3ST
        })
        Method (_S0W, 0, NotSerialized)  // _S0W: S0 Device Wake State
        {
            If (LEqual (ST_D, One))
            {
                Return (0x04)
            }
            Else
            {
                Return (Zero)
            }
        }

        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
        {
            If (LEqual (ST_D, One))
            {
                Store (0x88, IO80) /* \IO80 */
                Store (0xD6, SMIW) /* \_SB_.SMIW */
            }
        }

        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
        {
            If (LEqual (ST_D, One))
            {
                Store (0x77, IO80) /* \IO80 */
                Store (0xD5, SMIW) /* \_SB_.SMIW */
            }
        }
    }

    Scope (_SB.PCI0.LPC0.EC0)
    {
        Device (HWWD)
        {
            Name (_HID, EisaId ("WDT0001"))  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (SWTT, Zero)
            Name (WCNT, Zero)
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }

            Method (SWDT, 1, NotSerialized)
            {
                Store (Arg0, WCNT) /* \_SB_.PCI0.LPC0.EC0_.HWWD.WCNT */
                Store (Arg0, EWTL) /* \_SB_.PCI0.LPC0.EC0_.EWTL */
                And (Arg0, 0xFF00, Local0)
                ShiftRight (Local0, 0x08, Local1)
                Store (Local1, EWTH) /* \_SB_.PCI0.LPC0.EC0_.EWTH */
                Store (One, WDBE) /* \_SB_.PCI0.LPC0.EC0_.WDBE */
                Store (One, WDTE) /* \_SB_.PCI0.LPC0.EC0_.WDTE */
            }
        }
    }

    Scope (_SB.I2CD)
    {
        Device (TPDD)
        {
            Name (_HID, "ELAN2203")  // _HID: Hardware ID
            Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)  // _CID: Compatible ID
            Name (_UID, 0x05)  // _UID: Unique ID
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Name (RBUF, ResourceTemplate ()
                {
                    I2cSerialBus (0x0015, ControllerInitiated, 0x00061A80,
                        AddressingMode7Bit, "\\_SB.I2CD",
                        0x00, ResourceConsumer, ,
                        )
                    GpioInt (Edge, ActiveLow, Exclusive, PullNone, 0x0000,
                        "\\_SB.GPIO", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x0009
                        }
                })
                Return (RBUF) /* \_SB_.I2CD.TPDD._CRS.RBUF */
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (And (LGreaterEqual (TPOS, 0x60), LEqual (THPD, 0x04)))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_DSW, 3, NotSerialized)  // _DSW: Device Sleep Wake
            {
                If (Arg0) {}
                Else
                {
                }
            }

            Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
            {
            }

            Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
            {
            }

            Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
            {
                Name (_T_1, Zero)  // _T_x: Emitted by ASL Compiler
                Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
                If (LEqual (Arg0, ToUUID ("3cdff6f7-4267-4555-ad05-b30a3d8938de") /* HID I2C Device */))
                {
                    While (One)
                    {
                        Store (ToInteger (Arg2), _T_0) /* \_SB_.I2CD.TPDD._DSM._T_0 */
                        If (LEqual (_T_0, Zero))
                        {
                            While (One)
                            {
                                Store (ToInteger (Arg1), _T_1) /* \_SB_.I2CD.TPDD._DSM._T_1 */
                                If (LEqual (_T_1, One))
                                {
                                    Return (Buffer (One)
                                    {
                                         0x03                                             /* . */
                                    })
                                }
                                Else
                                {
                                    Return (Buffer (One)
                                    {
                                         0x00                                             /* . */
                                    })
                                }

                                Break
                            }
                        }
                        Else
                        {
                            If (LEqual (_T_0, One))
                            {
                                Return (One)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }

                        Break
                    }
                }
                Else
                {
                    Return (Buffer (One)
                    {
                         0x00                                             /* . */
                    })
                }
            }
        }
    }

    Scope (_SB.I2CC)
    {
        Device (TPNL)
        {
            Name (_HID, "WCOM48CF")  // _HID: Hardware ID
            Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)  // _CID: Compatible ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Name (_DDN, "Raydium Touchscreen")  // _DDN: DOS Device Name
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Name (RBUF, ResourceTemplate ()
                {
                    I2cSerialBus (0x000A, ControllerInitiated, 0x00061A80,
                        AddressingMode7Bit, "\\_SB.I2CC",
                        0x00, ResourceConsumer, ,
                        )
                    GpioInt (Level, ActiveLow, Exclusive, PullUp, 0x0000,
                        "\\_SB.GPIO", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x000C
                        }
                })
                Return (RBUF) /* \_SB_.I2CC.TPNL._CRS.RBUF */
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (And (LGreaterEqual (TPOS, 0x60), LEqual (THPN, 0x03)))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_DSW, 3, NotSerialized)  // _DSW: Device Sleep Wake
            {
                If (Arg0) {}
                Else
                {
                }
            }

            Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
            {
            }

            Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
            {
            }

            Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
            {
                Name (_T_1, Zero)  // _T_x: Emitted by ASL Compiler
                Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
                If (LEqual (Arg0, ToUUID ("3cdff6f7-4267-4555-ad05-b30a3d8938de") /* HID I2C Device */))
                {
                    While (One)
                    {
                        Store (ToInteger (Arg2), _T_0) /* \_SB_.I2CC.TPNL._DSM._T_0 */
                        If (LEqual (_T_0, Zero))
                        {
                            While (One)
                            {
                                Store (ToInteger (Arg1), _T_1) /* \_SB_.I2CC.TPNL._DSM._T_1 */
                                If (LEqual (_T_1, One))
                                {
                                    Return (Buffer (One)
                                    {
                                         0x03                                             /* . */
                                    })
                                }
                                Else
                                {
                                    Return (Buffer (One)
                                    {
                                         0x00                                             /* . */
                                    })
                                }

                                Break
                            }
                        }
                        Else
                        {
                            If (LEqual (_T_0, One))
                            {
                                Return (One)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }

                        Break
                    }
                }
                Else
                {
                    Return (Buffer (One)
                    {
                         0x00                                             /* . */
                    })
                }
            }
        }
    }

    Method (DTGP, 5, NotSerialized)
    {
        If (LEqual (Arg0, ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b")))
        {
            If (LEqual (Arg1, One))
            {
                If (LEqual (Arg2, Zero))
                {
                    Store (Buffer (One)
                        {
                             0x03                                             /* . */
                        }, Arg4)
                    Return (One)
                }

                If (LEqual (Arg2, One))
                {
                    Return (One)
                }
            }
        }

        Store (Buffer (One)
            {
                 0x00                                             /* . */
            }, Arg4)
        Return (Zero)
    }
}

