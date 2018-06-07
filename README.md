# Command line

Personal Windows command line scripting projects.

## Setup & usage

* You can Copy each file or add a link to C:\Users\<username>\AppData\Roaming\Microsoft\Windows\SendTo
* Or you can run the script in a CMD shell.

Require Windows version: 6.1

### compactvdi.cmd

It's a compact disk images command. Compact all VDI in the current directory and the Snapshots subfolder.

Require VBoxManage.exe from VirtualBox.

Copy the file or add a link to C:\Users\<username>\AppData\Roaming\Microsoft\Windows\SendTo

compactvdi.cmd can also be run in a CMD shell.

```batchfile
C:\Cmd\src> compactvdi.cmd "virtual machine directory"
```

### contiger.cmd

Defragments a specified file or files. Contig is a single-file defragmenter that attempts to make files contiguous on disk.
Its perfect for quickly optimizing files that are continuously becoming fragmented, or that you want to ensure are in as few fragments as possible.

Require contig.exe from Microsoft SysInternals.

Copy the file or add a link to C:\Users\<username>\AppData\Roaming\Microsoft\Windows\SendTo.

contiger.cmd can also be run in a CMD shell.

```batchfile
C:\Cmd\src> contiger.cmd "directory path"
```

### robocopyer.cmd

Robust directory replication command with robocopy tool.

Require robocopy.exe from Microsoft SysInternals. (may be included in your Microsoft Windows version)

Copy the file or add a link to C:\Users\<username>\AppData\Roaming\Microsoft\Windows\SendTo.

robocopyer.cmd can also be run in a CMD shell.

```batchfile
C:\Cmd\src> robocopyer.cmd "source directory path" "destination directory path" "log directory"

The destination directory will be created if it does not exist

The log directory will be created if it does not exist. default is C:\Temp
```

### vmdk2vdi.cmd

Duplicates a virtual .vmdk disk medium to a new .vdi image file with a new unique identifier (UUID).

Require VBoxManage.exe from VirtualBox.

Copy the file or add a link to C:\Users\<username>\AppData\Roaming\Microsoft\Windows\SendTo.

vmdk2vdi.cmd can also be run in a CMD shell.

```batchfile
C:\Cmd\src> vmdk2vdi.cmd "virtual machine directory"
```

### ziptimestamper.cmd

Compress file(s) or folder(s) and add a timestamp to the archive name.

Require 7-zip

Copy the file or add a link to C:\Users\<username>\AppData\Roaming\Microsoft\Windows\SendTo.

ziptimestamper.cmd can also be run in a CMD shell.

```batchfile
C:\Cmd\src> ziptimestamper.cmd "file to compress"
```

## Contributing

Thanks you for taking the time to contribute.

As this project is a personal project, I do not have time to develop new submitted features or feature requests. But if you encounter any **bugs**, please open an [issue](https://github.com/ojullien/cmd/issues/new).

Be sure to include a title and clear description,as much relevant information as possible, and a code sample or an executable test case demonstrating the expected behavior that is not occurring.

## License

This project is open-source and is licensed under the [MIT License](https://github.com/ojullien/cmd/blob/master/LICENSE).
