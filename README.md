# bof_scripts
Python2 scripts for Stack Buffer Overflows inspired by [dostackbufferoverflowgood](https://github.com/justinsteven/dostackbufferoverflowgood)

## Dependencies
1. msfvenom
2. python2
4. Immunity Debugger with mona.py

## Usage

1. `git clone https://github.com/thirdbyte/bof_scripts`
2. `cd bof_scripts`
3. `chmod +x *`

### Initialization

1. Set `RHOST` and `RPORT` in `config.py` according to the target

### 1_fuzz.py

1. Modify `config.py` to have a working `connect` function
2. `./1_fuzz.py`
3. Update `BUFT` in `config.py` to be slightly larger than the crashed bytes

### 2_find_offset.py

1. `./2_find_offset.py`
2. Copy the mona command, paste it in Immunity Debugger & run it
3. Note the EIP `OFFSET`

### 3_confirm_offset.py

1. Modify `OFFSET` of `config.py` to have the value found in the previous step
2. `./3_confirm_offset.py`
3. `ESP` should point to `CCCC`. If not, keep modifying `NO_B`, `NO_C` and `NO_Z` in `config.py`

### 4_find_badchars.py

1. Modify `config.py` and make sure that initially, `BADCHARS=[0x00,0x0A]`
2. `./4_badchars.py`
3. Copy `bad.bin` generated to target machine
4. In debugger, right click on `ESP` and click `Follow in Dump`
5. In debugger, execute `!mona compare -a esp -f c:\path\to\bad.bin`
6. Again modify `config.py` to add additional `BADCHARS`
7. Keep on repeating this step unless no `BADCHARS` are left

OR

1. Modify `config.py` and make sure that initially, `BADCHARS=[0x00,0x0A]`
2. `./4_badchars.py`
3. In debugger, right click on `ESP` and click `Follow in Dump`
4. Manually review the `BADCHARS`
5. Again modify `config.py` to add additional `BADCHARS`
6. Keep on repeating this step unless no `BADCHARS` are left

### 5_find_jmp_esp.py

1. `./5_find_jmp_esp.py`
2. Copy the mona command, paste it in Immunity Debugger & run it. Alternatively, execute `!mona modules` followed by `!mona find -s '\xff\xe4' -m module.dll` if the previous command does not return a `JMPESP`
3. Note the `JMPESP` address

### 6_confirm_jmp_esp.py

1. Modify `JMPESP` in `config.py` to have value found in previous step
2. `./6_confirm_jmp_esp.py`
3. Observe debugger for `INT 3` in disassembler. The highlighted `INT 3` should be the second instruction, followed by 2 more `INT 3` and 1 `INT 3` above. If a total of 4 `INT 3` are not visible each in a single line, then modify `NO_Z` accordingly

### 7_generate_shellcode.sh

1. `./7_generate_shellcode.sh`
2. Input `LHOST`, `LPORT` and `PLATFORM`

### 8_exploit.py 

1. `./8_exploit.py`

### compile.sh

1. `./compile.sh` creates a single python file named `final.py` for the exploit
