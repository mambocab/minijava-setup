## Getting Started

I've only ever got this to build on Ubuntu. I used [Vagrant][vagrant] to create an isolated Ubuntu environment. I've only used Vagrant on OS X, so YMMV. Vagrant depends on Ruby.

To set up the directory you'll be working in, start with

```sh
git clone https://github.com/mambocab/minijava-setup
cd minijava-setup
vagrant up
```

The first time you do this may take a while, since it will have to download the `ubuntu/trusty64` image.

Actually it'll take a while regardless, since it updates and downloads a number of packages with `apt`. But, that's ops!

If you can't use Vagrant, the `root_script` and `user_script` variables contain the scripts you need to run to get going. Actually doing that is left as an exercise to the reader.

Vagrant ✨ Does Some Excellent Magic ✨ and maps directories on your host machine to directories in your VM. What this allows you to do is edit the files in `source/` on your host machine, in your development environment of choice, and then compile them in your VM. The directories are current set up thusly:

- `source/*.j` are MiniJava source files that you can compile to test your changes.
- `source/MiniJavaLLVM` is the actual compiler.

So, open up `source/MiniJavaLLVM` in your IDE, and in the terminal (in the minijava-setup directory) run 

```sh
vagrant ssh
```

This `ssh`s you into the running VM, dropping you into a `bash` prompt. From there, run

```sh
cd /vagrant/
ls
```

Look familiar? This is the Ubuntu box's view onto the `minijava-setup` directory you were looking at before.

To compile MiniJavaLLVM:

```sh
cd /source/MiniJavaLLVM/
ant jar
```

I had a weird problem at some point with finding LLVM header files. I solved it by just running `ant ubuntu_depends` multiple times, even though it was already run as part of the Vagrant provisioning ¯\\_(ツ)_/¯

So, hopefully you now can compile stuff. For instance,

```
java -jar build/jar/mjc.jar -i ../ClassName.j --x86 output.s
```

Note that the compiler is in `build/jar/`. Command-line flags can be found in MiniJavaLLVM's README.

### Misc. Environment Notes

You may need to manually set the JDK you use as described [here](https://help.ubuntu.com/community/Java#Choosing_the_default_Java_to_use).

## Implementation

Notifications, in this system, are `Diagnostic`s. So are the actual errors raised when problems are encountered are also `Diagnostic`s. I've separated these out into two subclasses, `ThrownError`s and tktktktktk. Each `ThrownError` subclass is (should be?) unique to the site at which it's thrown -- that is to say, tktktktk is only thrown in a single file, exactly where that error is applicable.

[vagrant]: https://www.vagrantup.com/
[vagrantfile]: https://github.com/mambocab/minijava-setup/blob/master/Vagrantfile
