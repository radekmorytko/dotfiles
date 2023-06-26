## Kinesis advantage2 keyboard mappings for macOS

Note: keycodes can be found in the kinesis docs, present in the vDrive.


# Mapping files

* `l_qwerty.txt` - laptop mappings
* `m_qwerty.txt` - mac mappings

# First time mapping creation

* enter power user mode
* mount vDrive
* copy `l_qwery.txt` or `m_qwerty.txt` as `qwerty.txt` to vDrive
* unmount
* `prog+F2` and then press `l` or `m`, depends on which file you copied
* repeat for the other letter

# Setting custom mappings
* enter the PUM (power user mode, progm+shift+esc)
* mount vDrive (progm+F1)
* copy the layout file
  * to apply changes withouth unmounting: `progm+F3` (reloads qwerty mappings)
* unmount the disk (`diskutil unmount <device>`)
* deactive vDrive (progm+F1)
* deactivate power user mode

Mappings, keypad:
Left control -> Control
Left alt -> Option
Right alt -> Option
Right control -> Command
