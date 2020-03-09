-- VHDL Entity Board.lissajousGenerator_circuit.symbol
--
-- Created:
--          by - francois.francois (Aphelia)
--          at - 13:07:18 02/19/19
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2019.3 (Build 4)
--
LIBRARY ieee;
  USE ieee.std_logic_1164.all;
  USE ieee.numeric_std.all;

ENTITY lissajousGenerator_circuit IS
   GENERIC( 
      bitNb : positive := 16
   );
   PORT( 
      clock      : IN     std_ulogic;
      reset_N    : IN     std_ulogic;
      triggerOut : OUT    std_ulogic;
      xOut       : OUT    std_ulogic;
      yOut       : OUT    std_ulogic
   );

-- Declarations

END lissajousGenerator_circuit ;





-- VHDL Entity Board.DFF.symbol
--
-- Created:
--          by - francois.francois (Aphelia)
--          at - 13:07:05 02/19/19
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2019.3 (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY DFF IS
   PORT( 
      CLK : IN     std_uLogic;
      CLR : IN     std_uLogic;
      D   : IN     std_uLogic;
      Q   : OUT    std_uLogic
   );

-- Declarations

END DFF ;





ARCHITECTURE sim OF DFF IS
BEGIN

  process(clk, clr)
  begin
    if clr = '1' then
      q <= '0';
    elsif rising_edge(clk) then
      q <= d;
    end if;
  end process;

END ARCHITECTURE sim;





-- VHDL Entity Board.inverterIn.symbol
--
-- Created:
--          by - francois.francois (Aphelia)
--          at - 13:07:14 02/19/19
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2019.3 (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY inverterIn IS
   PORT( 
      in1  : IN     std_uLogic;
      out1 : OUT    std_uLogic
   );

-- Declarations

END inverterIn ;





ARCHITECTURE sim OF inverterIn IS
BEGIN

  out1 <= NOT in1;

END ARCHITECTURE sim;





-- VHDL Entity Lissajous.lissajousGenerator.symbol
--
-- Created:
--          by - francois.francois (Aphelia)
--          at - 13:07:53 02/19/19
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2019.3 (Build 4)
--
LIBRARY ieee;
  USE ieee.std_logic_1164.all;
  USE ieee.numeric_std.all;

ENTITY lissajousGenerator IS
   GENERIC( 
      signalBitNb : positive := 16;
      phaseBitNb  : positive := 16;
      stepX       : positive := 1;
      stepY       : positive := 1
   );
   PORT( 
      clock      : IN     std_ulogic;
      reset      : IN     std_ulogic;
      triggerOut : OUT    std_ulogic;
      xOut       : OUT    std_ulogic;
      yOut       : OUT    std_ulogic
   );

-- Declarations

END lissajousGenerator ;





-- VHDL Entity DigitalToAnalogConverter.DAC.symbol
--
-- Created:
--          by - francois.francois (Aphelia)
--          at - 13:06:08 02/19/19
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2019.3 (Build 4)
--
LIBRARY ieee;
  USE ieee.std_logic_1164.all;
  USE ieee.numeric_std.all;

ENTITY DAC IS
   GENERIC( 
      signalBitNb : positive := 16
   );
   PORT( 
      serialOut  : OUT    std_ulogic;
      parallelIn : IN     unsigned (signalBitNb-1 DOWNTO 0);
      clock      : IN     std_ulogic;
      reset      : IN     std_ulogic
   );

-- Declarations

END DAC ;





ARCHITECTURE masterVersion OF DAC IS

  signal parallelIn1: unsigned(parallelIn'range);
  signal integrator: unsigned(parallelIn'high+1 downto 0);
  signal quantized: std_ulogic;

BEGIN

--  parallelIn1 <= parallelIn;
  parallelIn1 <= parallelIn/2 + 2**(parallelIn'length-2);

  integrate: process(reset, clock)
  begin
    if reset = '1' then
      integrator <= (others => '0');
    elsif rising_edge(clock) then
      if quantized = '0' then
        integrator <= integrator + parallelIn1;
      else
        integrator <= integrator + parallelIn1 - 2**parallelIn'length;
      end if;
    end if;
  end process integrate;

  quantized <= integrator(integrator'high);

  serialOut <= quantized;

END ARCHITECTURE masterVersion;




-- VHDL Entity SplineInterpolator.sineGen.symbol
--
-- Created:
--          by - francois.francois (Aphelia)
--          at - 13:00:40 02/19/19
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2019.3 (Build 4)
--
LIBRARY ieee;
  USE ieee.std_logic_1164.all;
  USE ieee.numeric_std.all;

ENTITY sineGen IS
   GENERIC( 
      signalBitNb : positive := 16;
      phaseBitNb  : positive := 10
   );
   PORT( 
      clock    : IN     std_ulogic;
      reset    : IN     std_ulogic;
      step     : IN     unsigned (phaseBitNb-1 DOWNTO 0);
      sawtooth : OUT    unsigned (signalBitNb-1 DOWNTO 0);
      sine     : OUT    unsigned (signalBitNb-1 DOWNTO 0);
      square   : OUT    unsigned (signalBitNb-1 DOWNTO 0);
      triangle : OUT    unsigned (signalBitNb-1 DOWNTO 0)
   );

-- Declarations

END sineGen ;





-- VHDL Entity SplineInterpolator.interpolatorCoefficients.symbol
--
-- Created:
--          by - francois.francois (Aphelia)
--          at - 13:00:20 02/19/19
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2019.3 (Build 4)
--
LIBRARY ieee;
  USE ieee.std_logic_1164.all;
  USE ieee.numeric_std.all;

ENTITY interpolatorCoefficients IS
   GENERIC( 
      bitNb      : positive := 16;
      coeffBitNb : positive := 16
   );
   PORT( 
      sample1           : IN     signed (bitNb-1 DOWNTO 0);
      sample2           : IN     signed (bitNb-1 DOWNTO 0);
      sample3           : IN     signed (bitNb-1 DOWNTO 0);
      sample4           : IN     signed (bitNb-1 DOWNTO 0);
      a                 : OUT    signed (coeffBitNb-1 DOWNTO 0);
      b                 : OUT    signed (coeffBitNb-1 DOWNTO 0);
      c                 : OUT    signed (coeffBitNb-1 DOWNTO 0);
      d                 : OUT    signed (coeffBitNb-1 DOWNTO 0);
      interpolateLinear : IN     std_ulogic
   );

-- Declarations

END interpolatorCoefficients ;





ARCHITECTURE masterVersion OF interpolatorCoefficients IS
BEGIN

  calcCoeffs: process(interpolateLinear, sample1, sample2, sample3, sample4)
  begin
    if interpolateLinear = '1' then
      a <= (others => '0');
      b <= (others => '0');
      c <=   resize(2*sample3, c'length)
           - resize(2*sample2, c'length);
      d <=   resize(  sample2, d'length);
    else
      a <=   resize(  sample4, a'length)
           - resize(3*sample3, a'length)
           + resize(3*sample2, a'length)
           - resize(  sample1, a'length);
      b <=   resize(2*sample1, b'length)
           - resize(5*sample2, b'length)
           + resize(4*sample3, b'length)
           - resize(  sample4, b'length);
      c <=   resize(  sample3, c'length)
           - resize(  sample1, c'length);
      d <=   resize(  sample2, d'length);
    end if;
  end process calcCoeffs;

END ARCHITECTURE masterVersion;





-- VHDL Entity WaveformGenerator.sawtoothGen.symbol
--
-- Created:
--          by - francois.francois (Aphelia)
--          at - 08:02:49 03/11/19
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2019.3 (Build 4)
--
LIBRARY ieee;
  USE ieee.std_logic_1164.all;
  USE ieee.numeric_std.all;

ENTITY sawtoothGen IS
   GENERIC( 
      bitNb : positive := 16
   );
   PORT( 
      sawtooth : OUT    unsigned (bitNb-1 DOWNTO 0);
      clock    : IN     std_ulogic;
      reset    : IN     std_ulogic;
      step     : IN     unsigned (bitNb-1 DOWNTO 0);
      en       : IN     std_ulogic
   );

-- Declarations

END sawtoothGen ;





ARCHITECTURE masterVersion OF sawtoothGen IS

  signal counter: unsigned(sawtooth'range);

begin

  count: process(reset, clock)
  begin
    if reset = '1' then
      counter <= (others => '0');
    elsif rising_edge(clock) then
      if en = '1' then
        counter <= counter + step;
      end if;
    end if;
  end process count;

  sawtooth <= counter;

END ARCHITECTURE masterVersion;





-- VHDL Entity SplineInterpolator.interpolatorShiftRegister.symbol
--
-- Created:
--          by - francois.francois (Aphelia)
--          at - 13:00:24 02/19/19
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2019.3 (Build 4)
--
LIBRARY ieee;
  USE ieee.std_logic_1164.all;
  USE ieee.numeric_std.all;

ENTITY interpolatorShiftRegister IS
   GENERIC( 
      signalBitNb : positive := 16
   );
   PORT( 
      clock        : IN     std_ulogic;
      reset        : IN     std_ulogic;
      shiftSamples : IN     std_ulogic;
      sampleIn     : IN     signed (signalBitNb-1 DOWNTO 0);
      sample1      : OUT    signed (signalBitNb-1 DOWNTO 0);
      sample2      : OUT    signed (signalBitNb-1 DOWNTO 0);
      sample3      : OUT    signed (signalBitNb-1 DOWNTO 0);
      sample4      : OUT    signed (signalBitNb-1 DOWNTO 0)
   );

-- Declarations

END interpolatorShiftRegister ;





ARCHITECTURE masterVersion OF interpolatorShiftRegister IS

  signal sample4_int: signed(sampleIn'range);
  signal sample3_int: signed(sampleIn'range);
  signal sample2_int: signed(sampleIn'range);
  signal sample1_int: signed(sampleIn'range);

begin

  shiftThem: process(reset, clock)
  begin
    if reset = '1' then
      sample1_int <= (others => '0');
      sample2_int <= (others => '0');
      sample3_int <= (others => '0');
      sample4_int <= (others => '0');
    elsif rising_edge(clock) then
      if shiftSamples = '1' then
        sample1_int <= sample2_int;
        sample2_int <= sample3_int;
        sample3_int <= sample4_int;
        sample4_int <= sampleIn;
      end if;
    end if;
  end process shiftThem;

  sample4 <= sample4_int;
  sample3 <= sample3_int;
  sample2 <= sample2_int;
  sample1 <= sample1_int;

END ARCHITECTURE masterVersion;




-- VHDL Entity SplineInterpolator.sineTable.symbol
--
-- Created:
--          by - francois.francois (Aphelia)
--          at - 13:00:46 02/19/19
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2019.3 (Build 4)
--
LIBRARY ieee;
  USE ieee.std_logic_1164.all;
  USE ieee.numeric_std.all;

ENTITY sineTable IS
   GENERIC( 
      inputBitNb        : positive := 16;
      outputBitNb       : positive := 16;
      tableAddressBitNb : positive := 3
   );
   PORT( 
      sine  : OUT    signed (outputBitNb-1 DOWNTO 0);
      phase : IN     unsigned (inputBitNb-1 DOWNTO 0)
   );

-- Declarations

END sineTable ;





ARCHITECTURE masterVersion OF sineTable IS

  signal changeSign : std_uLogic;
  signal flipPhase : std_uLogic;
  signal phaseTableAddress1 : unsigned(tableAddressBitNb-1 downto 0);
  signal phaseTableAddress2 : unsigned(phaseTableAddress1'range);
  signal quarterSine : signed(sine'range);

  signal shiftPhase : std_uLogic := '0';  -- can be used to build a cosine

begin

  changeSign <= phase(phase'high);
  flipPhase <= phase(phase'high-1);

  phaseTableAddress1 <= phase(phase'high-2 downto phase'high-2-tableAddressBitNb+1);

  checkPhase: process(flipPhase, shiftPhase, phaseTableAddress1)
  begin
    if (flipPhase xor shiftPhase) = '0' then
      phaseTableAddress2 <= phaseTableAddress1;
    else
      phaseTableAddress2 <= 0 - phaseTableAddress1;
    end if;
  end process checkPhase;


  quarterTable: process(phaseTableAddress2, flipPhase, shiftPhase)
  begin
    case to_integer(phaseTableAddress2) is
      when 0 => if (flipPhase xor shiftPhase) = '0' then
                  quarterSine <= to_signed(16#0000#, quarterSine'length);
                else
                  quarterSine <= to_signed(16#7FFF#, quarterSine'length);
                end if;
      when 1 => quarterSine <= to_signed(16#18F9#, quarterSine'length);
      when 2 => quarterSine <= to_signed(16#30FB#, quarterSine'length);
      when 3 => quarterSine <= to_signed(16#471C#, quarterSine'length);
      when 4 => quarterSine <= to_signed(16#5A82#, quarterSine'length);
      when 5 => quarterSine <= to_signed(16#6A6D#, quarterSine'length);
      when 6 => quarterSine <= to_signed(16#7641#, quarterSine'length);
      when 7 => quarterSine <= to_signed(16#7D89#, quarterSine'length);
      when others => quarterSine <= (others => '-');
    end case;
  end process quarterTable;

  checkSign: process(changeSign, flipPhase, shiftPhase, quarterSine)
  begin
    if (changeSign xor (flipPhase and shiftPhase)) = '0' then
      sine <= quarterSine;
    else
      sine <= 0 - quarterSine;
    end if;
  end process checkSign;

END ARCHITECTURE masterVersion;





-- VHDL Entity SplineInterpolator.resizer.symbol
--
-- Created:
--          by - francois.francois (Aphelia)
--          at - 13:00:36 02/19/19
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2019.3 (Build 4)
--
LIBRARY ieee;
  USE ieee.std_logic_1164.all;
  USE ieee.numeric_std.all;

ENTITY resizer IS
   GENERIC( 
      inputBitNb  : positive := 16;
      outputBitNb : positive := 16
   );
   PORT( 
      resizeOut : OUT    unsigned (outputBitNb-1 DOWNTO 0);
      resizeIn  : IN     unsigned (inputBitNb-1 DOWNTO 0)
   );

-- Declarations

END resizer ;





ARCHITECTURE masterVersion OF resizer IS

BEGIN

  outGtIn: if resizeOut'length > resizeIn'length generate
  begin
    resizeOut <= shift_left(
      resize(
        resizeIn,
        resizeOut'length
      ),
      resizeOut'length-resizeIn'length
    );
  end generate outGtIn;

  outEqIn: if resizeOut'length = resizeIn'length generate
  begin
    resizeOut <= resizeIn;
  end generate outEqIn;

  outLtIn: if resizeOut'length < resizeIn'length generate
  begin
    resizeOut <= resize(
      shift_right(
        resizeIn,
        resizeIn'length-resizeOut'length
      ),
      resizeOut'length
    );
  end generate outLtIn;

END ARCHITECTURE masterVersion;





-- VHDL Entity SplineInterpolator.interpolatorCalculatePolynom.symbol
--
-- Created:
--          by - francois.francois (Aphelia)
--          at - 13:00:14 02/19/19
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2019.3 (Build 4)
--
LIBRARY ieee;
  USE ieee.std_logic_1164.all;
  USE ieee.numeric_std.all;

ENTITY interpolatorCalculatePolynom IS
   GENERIC( 
      signalBitNb       : positive := 16;
      coeffBitNb        : positive := 16;
      oversamplingBitNb : positive := 8
   );
   PORT( 
      clock          : IN     std_ulogic;
      reset          : IN     std_ulogic;
      restartPolynom : IN     std_ulogic;
      d              : IN     signed (coeffBitNb-1 DOWNTO 0);
      sampleOut      : OUT    signed (signalBitNb-1 DOWNTO 0);
      c              : IN     signed (coeffBitNb-1 DOWNTO 0);
      b              : IN     signed (coeffBitNb-1 DOWNTO 0);
      a              : IN     signed (coeffBitNb-1 DOWNTO 0);
      en             : IN     std_ulogic
   );

-- Declarations

END interpolatorCalculatePolynom ;





ARCHITECTURE masterVersion OF interpolatorCalculatePolynom IS

  constant additionalBitNb: positive := 1;
  constant internalsBitNb: positive := signalBitNb + 3*oversamplingBitNb + 1
    + additionalBitNb;
  signal x: signed(internalsBitNb-1 downto 0);
  signal u: signed(internalsBitNb-1 downto 0);
  signal v: signed(internalsBitNb-1 downto 0);
  signal w: signed(internalsBitNb-1 downto 0);

BEGIN

  iterativePolynom: process(reset, clock)
  begin
    if reset = '1' then
      x <= (others => '0');
      u <= (others => '0');
      v <= (others => '0');
      w <= (others => '0');
      sampleOut <= (others => '0');
    elsif rising_edge(clock) then
      if en = '1' then
        if restartPolynom = '1' then
          x <=   shift_left(resize(2*d, x'length), 3*oversamplingBitNb);
          u <=   resize(a, u'length)
               + shift_left(resize(b, u'length), oversamplingBitNb)
               + shift_left(resize(c, u'length), 2*oversamplingBitNb);
          v <=   resize(6*a, v'length)
               + shift_left(resize(2*b, v'length), oversamplingBitNb);
          w <=   resize(6*a, w'length);
          sampleOut <= resize(d, sampleOut'length);
        else
          x <= x + u;
          u <= u + v;
          v <= v + w;
          sampleOut <= resize(
            shift_right(x, 3*oversamplingBitNb+1), sampleOut'length
          );
                                                               -- limit overflow
          if x(x'high downto x'high-additionalBitNb) = "01" then
            sampleOut <= not shift_left(
              resize("10", sampleOut'length), sampleOut'length-2
            );
          end if;
                                                              -- limit underflow
          if x(x'high downto x'high-additionalBitNb) = "10" then
            sampleOut <= shift_left(
              resize("10", sampleOut'length), sampleOut'length-2
            );
          end if;
        end if;
      end if;
    end if;
  end process iterativePolynom;

END ARCHITECTURE masterVersion;




-- VHDL Entity WaveformGenerator.sawtoothToSquare.symbol
--
-- Created:
--          by - francois.francois (Aphelia)
--          at - 08:02:49 03/11/19
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2019.3 (Build 4)
--
LIBRARY ieee;
  USE ieee.std_logic_1164.all;
  USE ieee.numeric_std.all;

ENTITY sawtoothToSquare IS
   GENERIC( 
      bitNb : positive := 16
   );
   PORT( 
      square   : OUT    unsigned (bitNb-1 DOWNTO 0);
      sawtooth : IN     unsigned (bitNb-1 DOWNTO 0)
   );

-- Declarations

END sawtoothToSquare ;





ARCHITECTURE masterVersion OF sawtoothToSquare IS
BEGIN

  square <= (others => sawtooth(sawtooth'high));

END ARCHITECTURE masterVersion;




-- VHDL Entity WaveformGenerator.sawtoothToTriangle.symbol
--
-- Created:
--          by - francois.francois (Aphelia)
--          at - 08:02:49 03/11/19
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2019.3 (Build 4)
--
LIBRARY ieee;
  USE ieee.std_logic_1164.all;
  USE ieee.numeric_std.all;

ENTITY sawtoothToTriangle IS
   GENERIC( 
      bitNb : positive := 16
   );
   PORT( 
      triangle : OUT    unsigned (bitNb-1 DOWNTO 0);
      sawtooth : IN     unsigned (bitNb-1 DOWNTO 0)
   );

-- Declarations

END sawtoothToTriangle ;





ARCHITECTURE masterVersion OF sawtoothToTriangle IS

  signal MSB: std_uLogic;
  signal triangleInt: unsigned(triangle'range);

begin

  MSB <= sawtooth(sawtooth'high);

  foldDown: process(MSB, sawtooth)
  begin
    if MSB = '0' then
      triangleInt <= sawtooth;
    else
      triangleInt <= not sawtooth;
    end if;
  end process foldDown;

  triangle <= triangleInt(triangleInt'high-1 downto 0) & '0';

END ARCHITECTURE masterVersion;




-- VHDL Entity SplineInterpolator.interpolatorTrigger.symbol
--
-- Created:
--          by - francois.francois (Aphelia)
--          at - 13:00:28 02/19/19
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2019.3 (Build 4)
--
LIBRARY ieee;
  USE ieee.std_logic_1164.all;
  USE ieee.numeric_std.all;

ENTITY interpolatorTrigger IS
   GENERIC( 
      counterBitNb : positive := 4
   );
   PORT( 
      triggerOut : OUT    std_ulogic;
      clock      : IN     std_ulogic;
      reset      : IN     std_ulogic;
      en         : IN     std_ulogic
   );

-- Declarations

END interpolatorTrigger ;





ARCHITECTURE masterVersion OF interpolatorTrigger IS

  signal triggerCounter: unsigned(counterBitNb-1 downto 0);

BEGIN

  count: process(reset, clock)
  begin
    if reset = '1' then
      triggerCounter <= (others => '0');
    elsif rising_edge(clock) then
      if en = '1' then
        triggerCounter <= triggerCounter + 1;
      end if;
    end if;
  end process count;

  trig: process(triggerCounter, en)
  begin
    if triggerCounter = 0 then
      triggerOut <= en;
    else
      triggerOut <= '0';
    end if;
  end process trig;

END ARCHITECTURE masterVersion;




-- VHDL Entity SplineInterpolator.offsetToUnsigned.symbol
--
-- Created:
--          by - francois.francois (Aphelia)
--          at - 13:00:32 02/19/19
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2019.3 (Build 4)
--
LIBRARY ieee;
  USE ieee.std_logic_1164.all;
  USE ieee.numeric_std.all;

ENTITY offsetToUnsigned IS
   GENERIC( 
      bitNb : positive := 16
   );
   PORT( 
      unsignedOut : OUT    unsigned (bitNb-1 DOWNTO 0);
      signedIn    : IN     signed (bitNb-1 DOWNTO 0)
   );

-- Declarations

END offsetToUnsigned ;





ARCHITECTURE masterVersion OF offsetToUnsigned IS

BEGIN

  unsignedOut <= not(signedIn(signedIn'high)) & unsigned(signedIn(signedIn'high-1 downto 0));

END ARCHITECTURE masterVersion;




--
-- VHDL Architecture SplineInterpolator.sineGen.struct
--
-- Created:
--          by - francois.francois (Aphelia)
--          at - 13:00:40 02/19/19
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2019.3 (Build 4)
--
LIBRARY ieee;
  USE ieee.std_logic_1164.all;
  USE ieee.numeric_std.all;

-- LIBRARY SplineInterpolator;
-- LIBRARY WaveformGenerator;

ARCHITECTURE struct OF sineGen IS

   -- Architecture declarations
   constant tableAddressBitNb : positive := 3;
   constant sampleCountBitNb : positive := phaseBitNb-2-tableAddressBitNb;
   constant coeffBitNb : positive := signalBitNb+4;

   -- Internal signal declarations
   SIGNAL a           : signed(coeffBitNb-1 DOWNTO 0);
   SIGNAL b           : signed(coeffBitNb-1 DOWNTO 0);
   SIGNAL c           : signed(coeffBitNb-1 DOWNTO 0);
   SIGNAL d           : signed(coeffBitNb-1 DOWNTO 0);
   SIGNAL logic0      : std_ulogic;
   SIGNAL logic1      : std_ulogic;
   SIGNAL newPolynom  : std_ulogic;
   SIGNAL phase       : unsigned(phaseBitNb-1 DOWNTO 0);
   SIGNAL sample1     : signed(signalBitNb-1 DOWNTO 0);
   SIGNAL sample2     : signed(signalBitNb-1 DOWNTO 0);
   SIGNAL sample3     : signed(signalBitNb-1 DOWNTO 0);
   SIGNAL sample4     : signed(signalBitNb-1 DOWNTO 0);
   SIGNAL sineSamples : signed(signalBitNb-1 DOWNTO 0);
   SIGNAL sineSigned  : signed(signalBitNb-1 DOWNTO 0);

   -- Implicit buffer signal declarations
   SIGNAL sawtooth_internal : unsigned (signalBitNb-1 DOWNTO 0);


   -- Component Declarations
   COMPONENT interpolatorCalculatePolynom
   GENERIC (
      signalBitNb       : positive := 16;
      coeffBitNb        : positive := 16;
      oversamplingBitNb : positive := 8
   );
   PORT (
      clock          : IN     std_ulogic ;
      reset          : IN     std_ulogic ;
      restartPolynom : IN     std_ulogic ;
      d              : IN     signed (coeffBitNb-1 DOWNTO 0);
      sampleOut      : OUT    signed (signalBitNb-1 DOWNTO 0);
      c              : IN     signed (coeffBitNb-1 DOWNTO 0);
      b              : IN     signed (coeffBitNb-1 DOWNTO 0);
      a              : IN     signed (coeffBitNb-1 DOWNTO 0);
      en             : IN     std_ulogic 
   );
   END COMPONENT;
   COMPONENT interpolatorCoefficients
   GENERIC (
      bitNb      : positive := 16;
      coeffBitNb : positive := 16
   );
   PORT (
      sample1           : IN     signed (bitNb-1 DOWNTO 0);
      sample2           : IN     signed (bitNb-1 DOWNTO 0);
      sample3           : IN     signed (bitNb-1 DOWNTO 0);
      sample4           : IN     signed (bitNb-1 DOWNTO 0);
      a                 : OUT    signed (coeffBitNb-1 DOWNTO 0);
      b                 : OUT    signed (coeffBitNb-1 DOWNTO 0);
      c                 : OUT    signed (coeffBitNb-1 DOWNTO 0);
      d                 : OUT    signed (coeffBitNb-1 DOWNTO 0);
      interpolateLinear : IN     std_ulogic 
   );
   END COMPONENT;
   COMPONENT interpolatorShiftRegister
   GENERIC (
      signalBitNb : positive := 16
   );
   PORT (
      clock        : IN     std_ulogic ;
      reset        : IN     std_ulogic ;
      shiftSamples : IN     std_ulogic ;
      sampleIn     : IN     signed (signalBitNb-1 DOWNTO 0);
      sample1      : OUT    signed (signalBitNb-1 DOWNTO 0);
      sample2      : OUT    signed (signalBitNb-1 DOWNTO 0);
      sample3      : OUT    signed (signalBitNb-1 DOWNTO 0);
      sample4      : OUT    signed (signalBitNb-1 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT interpolatorTrigger
   GENERIC (
      counterBitNb : positive := 4
   );
   PORT (
      triggerOut : OUT    std_ulogic ;
      clock      : IN     std_ulogic ;
      reset      : IN     std_ulogic ;
      en         : IN     std_ulogic 
   );
   END COMPONENT;
   COMPONENT offsetToUnsigned
   GENERIC (
      bitNb : positive := 16
   );
   PORT (
      unsignedOut : OUT    unsigned (bitNb-1 DOWNTO 0);
      signedIn    : IN     signed (bitNb-1 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT resizer
   GENERIC (
      inputBitNb  : positive := 16;
      outputBitNb : positive := 16
   );
   PORT (
      resizeOut : OUT    unsigned (outputBitNb-1 DOWNTO 0);
      resizeIn  : IN     unsigned (inputBitNb-1 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT sineTable
   GENERIC (
      inputBitNb        : positive := 16;
      outputBitNb       : positive := 16;
      tableAddressBitNb : positive := 3
   );
   PORT (
      sine  : OUT    signed (outputBitNb-1 DOWNTO 0);
      phase : IN     unsigned (inputBitNb-1 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT sawtoothGen
   GENERIC (
      bitNb : positive := 16
   );
   PORT (
      sawtooth : OUT    unsigned (bitNb-1 DOWNTO 0);
      clock    : IN     std_ulogic ;
      reset    : IN     std_ulogic ;
      step     : IN     unsigned (bitNb-1 DOWNTO 0);
      en       : IN     std_ulogic 
   );
   END COMPONENT;
   COMPONENT sawtoothToSquare
   GENERIC (
      bitNb : positive := 16
   );
   PORT (
      square   : OUT    unsigned (bitNb-1 DOWNTO 0);
      sawtooth : IN     unsigned (bitNb-1 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT sawtoothToTriangle
   GENERIC (
      bitNb : positive := 16
   );
   PORT (
      triangle : OUT    unsigned (bitNb-1 DOWNTO 0);
      sawtooth : IN     unsigned (bitNb-1 DOWNTO 0)
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
--    FOR ALL : interpolatorCalculatePolynom USE ENTITY SplineInterpolator.interpolatorCalculatePolynom;
--    FOR ALL : interpolatorCoefficients USE ENTITY SplineInterpolator.interpolatorCoefficients;
--    FOR ALL : interpolatorShiftRegister USE ENTITY SplineInterpolator.interpolatorShiftRegister;
--    FOR ALL : interpolatorTrigger USE ENTITY SplineInterpolator.interpolatorTrigger;
--    FOR ALL : offsetToUnsigned USE ENTITY SplineInterpolator.offsetToUnsigned;
--    FOR ALL : resizer USE ENTITY SplineInterpolator.resizer;
--    FOR ALL : sawtoothGen USE ENTITY WaveformGenerator.sawtoothGen;
--    FOR ALL : sawtoothToSquare USE ENTITY WaveformGenerator.sawtoothToSquare;
--    FOR ALL : sawtoothToTriangle USE ENTITY WaveformGenerator.sawtoothToTriangle;
--    FOR ALL : sineTable USE ENTITY SplineInterpolator.sineTable;
   -- pragma synthesis_on


BEGIN
   -- Architecture concurrent statements
   -- HDL Embedded Text Block 2 eb2
   logic1 <= '1';

   -- HDL Embedded Text Block 3 eb3
   logic0 <= '0';


   -- Instance port mappings.
   I_spline : interpolatorCalculatePolynom
      GENERIC MAP (
         signalBitNb       => signalBitNb,
         coeffBitNb        => coeffBitNb,
         oversamplingBitNb => sampleCountBitNb
      )
      PORT MAP (
         clock          => clock,
         reset          => reset,
         restartPolynom => newPolynom,
         d              => d,
         sampleOut      => sineSigned,
         c              => c,
         b              => b,
         a              => a,
         en             => logic1
      );
   I_coeffs : interpolatorCoefficients
      GENERIC MAP (
         bitNb      => signalBitNb,
         coeffBitNb => coeffBitNb
      )
      PORT MAP (
         sample1           => sample1,
         sample2           => sample2,
         sample3           => sample3,
         sample4           => sample4,
         a                 => a,
         b                 => b,
         c                 => c,
         d                 => d,
         interpolateLinear => logic0
      );
   I_shReg : interpolatorShiftRegister
      GENERIC MAP (
         signalBitNb => signalBitNb
      )
      PORT MAP (
         clock        => clock,
         reset        => reset,
         shiftSamples => newPolynom,
         sampleIn     => sineSamples,
         sample1      => sample1,
         sample2      => sample2,
         sample3      => sample3,
         sample4      => sample4
      );
   I_trig : interpolatorTrigger
      GENERIC MAP (
         counterBitNb => sampleCountBitNb
      )
      PORT MAP (
         triggerOut => newPolynom,
         clock      => clock,
         reset      => reset,
         en         => logic1
      );
   I_unsigned : offsetToUnsigned
      GENERIC MAP (
         bitNb => signalBitNb
      )
      PORT MAP (
         unsignedOut => sine,
         signedIn    => sineSigned
      );
   I_size : resizer
      GENERIC MAP (
         inputBitNb  => phaseBitNb,
         outputBitNb => signalBitNb
      )
      PORT MAP (
         resizeOut => sawtooth_internal,
         resizeIn  => phase
      );
   I_sin : sineTable
      GENERIC MAP (
         inputBitNb        => phaseBitNb,
         outputBitNb       => signalBitNb,
         tableAddressBitNb => tableAddressBitNb
      )
      PORT MAP (
         sine  => sineSamples,
         phase => phase
      );
   I_saw : sawtoothGen
      GENERIC MAP (
         bitNb => phaseBitNb
      )
      PORT MAP (
         sawtooth => phase,
         clock    => clock,
         reset    => reset,
         step     => step,
         en       => logic1
      );
   I_square : sawtoothToSquare
      GENERIC MAP (
         bitNb => signalBitNb
      )
      PORT MAP (
         square   => square,
         sawtooth => sawtooth_internal
      );
   I_tri : sawtoothToTriangle
      GENERIC MAP (
         bitNb => signalBitNb
      )
      PORT MAP (
         triangle => triangle,
         sawtooth => sawtooth_internal
      );

   -- Implicit buffered output assignments
   sawtooth <= sawtooth_internal;

END struct;




--
-- VHDL Architecture Lissajous.lissajousGenerator.struct
--
-- Created:
--          by - zas.UNKNOWN (ZELL)
--          at - 14:14:35 02/20/2020
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2019.3 (Build 4)
--
LIBRARY ieee;
  USE ieee.std_logic_1164.all;
  USE ieee.numeric_std.all;

-- LIBRARY DigitalToAnalogConverter;
-- LIBRARY SplineInterpolator;

ARCHITECTURE struct OF lissajousGenerator IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL sineX         : unsigned(signalBitNb-1 DOWNTO 0);
   SIGNAL sineY         : unsigned(signalBitNb-1 DOWNTO 0);
   SIGNAL squareY       : unsigned(signalBitNb-1 DOWNTO 0);
   SIGNAL stepXUnsigned : unsigned(phaseBitNb-1 DOWNTO 0);
   SIGNAL stepYUnsigned : unsigned(phaseBitNb-1 DOWNTO 0);


   -- Component Declarations
   COMPONENT DAC
   GENERIC (
      signalBitNb : positive := 16
   );
   PORT (
      serialOut  : OUT    std_ulogic ;
      parallelIn : IN     unsigned (signalBitNb-1 DOWNTO 0);
      clock      : IN     std_ulogic ;
      reset      : IN     std_ulogic 
   );
   END COMPONENT;
   COMPONENT sineGen
   GENERIC (
      signalBitNb : positive := 16;
      phaseBitNb  : positive := 10
   );
   PORT (
      clock    : IN     std_ulogic ;
      reset    : IN     std_ulogic ;
      step     : IN     unsigned (phaseBitNb-1 DOWNTO 0);
      sawtooth : OUT    unsigned (signalBitNb-1 DOWNTO 0);
      sine     : OUT    unsigned (signalBitNb-1 DOWNTO 0);
      square   : OUT    unsigned (signalBitNb-1 DOWNTO 0);
      triangle : OUT    unsigned (signalBitNb-1 DOWNTO 0)
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
--    FOR ALL : DAC USE ENTITY DigitalToAnalogConverter.DAC;
--    FOR ALL : sineGen USE ENTITY SplineInterpolator.sineGen;
   -- pragma synthesis_on


BEGIN
   -- Architecture concurrent statements
   -- HDL Embedded Text Block 1 eb1
   triggerOut <= squareY(squareY'high);

   -- HDL Embedded Text Block 2 eb2
   stepXUnsigned <= to_unsigned(stepX, stepXUnsigned'length);

   -- HDL Embedded Text Block 3 eb3
   stepYUnsigned <= to_unsigned(stepY, stepYUnsigned'length);


   -- Instance port mappings.
   I_dacX : DAC
      GENERIC MAP (
         signalBitNb => signalBitNb
      )
      PORT MAP (
         serialOut  => xOut,
         parallelIn => sineX,
         clock      => clock,
         reset      => reset
      );
   I_dacY : DAC
      GENERIC MAP (
         signalBitNb => signalBitNb
      )
      PORT MAP (
         serialOut  => yOut,
         parallelIn => sineY,
         clock      => clock,
         reset      => reset
      );
   I_sinX : sineGen
      GENERIC MAP (
         signalBitNb => signalBitNb,
         phaseBitNb  => phaseBitNb
      )
      PORT MAP (
         clock    => clock,
         reset    => reset,
         step     => stepXUnsigned,
         sawtooth => OPEN,
         sine     => sineX,
         square   => OPEN,
         triangle => OPEN
      );
   I_sinY : sineGen
      GENERIC MAP (
         signalBitNb => signalBitNb,
         phaseBitNb  => phaseBitNb
      )
      PORT MAP (
         clock    => clock,
         reset    => reset,
         step     => stepYUnsigned,
         sawtooth => OPEN,
         sine     => sineY,
         square   => squareY,
         triangle => OPEN
      );

END struct;




--
-- VHDL Architecture Board.lissajousGenerator_circuit.masterVersion
--
-- Created:
--          by - zas.UNKNOWN (ZELL)
--          at - 14:16:11 02/20/2020
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2019.3 (Build 4)
--
LIBRARY ieee;
  USE ieee.std_logic_1164.all;
  USE ieee.numeric_std.all;

-- LIBRARY Board;
-- LIBRARY Lissajous;

ARCHITECTURE masterVersion OF lissajousGenerator_circuit IS

   -- Architecture declarations
   constant signalBitNb: positive := 16;
   constant phaseBitNb: positive := 17;
   constant stepX: positive := 3;
   constant stepY: positive := 4;

   -- Internal signal declarations
   SIGNAL logic1      : std_uLogic;
   SIGNAL reset       : std_ulogic;
   SIGNAL resetSnch_N : std_ulogic;
   SIGNAL resetSynch  : std_ulogic;


   -- Component Declarations
   COMPONENT DFF
   PORT (
      CLK : IN     std_uLogic ;
      CLR : IN     std_uLogic ;
      D   : IN     std_uLogic ;
      Q   : OUT    std_uLogic 
   );
   END COMPONENT;
   COMPONENT inverterIn
   PORT (
      in1  : IN     std_uLogic ;
      out1 : OUT    std_uLogic 
   );
   END COMPONENT;
   COMPONENT lissajousGenerator
   GENERIC (
      signalBitNb : positive := 16;
      phaseBitNb  : positive := 16;
      stepX       : positive := 1;
      stepY       : positive := 1
   );
   PORT (
      clock      : IN     std_ulogic ;
      reset      : IN     std_ulogic ;
      triggerOut : OUT    std_ulogic ;
      xOut       : OUT    std_ulogic ;
      yOut       : OUT    std_ulogic 
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
--    FOR ALL : DFF USE ENTITY Board.DFF;
--    FOR ALL : inverterIn USE ENTITY Board.inverterIn;
--    FOR ALL : lissajousGenerator USE ENTITY Lissajous.lissajousGenerator;
   -- pragma synthesis_on


BEGIN
   -- Architecture concurrent statements
   -- HDL Embedded Text Block 4 eb4
   logic1 <= '1';


   -- Instance port mappings.
   I_dff : DFF
      PORT MAP (
         CLK => clock,
         CLR => reset,
         D   => logic1,
         Q   => resetSnch_N
      );
   I_inv1 : inverterIn
      PORT MAP (
         in1  => reset_N,
         out1 => reset
      );
   I_inv2 : inverterIn
      PORT MAP (
         in1  => resetSnch_N,
         out1 => resetSynch
      );
   I_main : lissajousGenerator
      GENERIC MAP (
         signalBitNb => signalBitNb,
         phaseBitNb  => phaseBitNb,
         stepX       => stepX,
         stepY       => stepY
      )
      PORT MAP (
         clock      => clock,
         reset      => resetSynch,
         triggerOut => triggerOut,
         xOut       => xOut,
         yOut       => yOut
      );

END masterVersion;




