## Getting Started

I've only ever got this to build on Ubuntu. I used [Vagrant][vagrant] to create an isolated Ubuntu environment. I've only used Vagrant on OS X, so YMMV. Vagrant depends on Ruby.

If you're running on Windows, you may need to get an ssh executable installed. On @captainemerson's machine, installing Cygwin with OpenSSH worked. (Including OpenSSH may not have been necessary. You can experiment with this if you want.)

To set up the directory you'll be working in, start with

```sh
git clone https://github.com/mambocab/minijava-setup
cd minijava-setup
vagrant up
```

The first time you do this may take a while, since it will have to download the `ubuntu/trusty32` image.

Actually it'll take a while regardless, since it updates and downloads a number of packages with `apt`. But, that's ops!

If you can't use Vagrant, the `root_script` and `user_script` variables contain the scripts you need to run to get going. Actually doing that is left as an exercise to the reader.

Vagrant ✨ Does Some Excellent Magic ✨ and maps directories on your host machine to directories in your VM. What this allows you to do is edit the files in `source/` on your host machine, in your development environment of choice, and then compile them in your VM. The directories are current set up thusly:

- `source/*.j` are MiniJava source files that you can compile to test your changes.
- `source/MiniJavaLLVM` is the actual compiler.

So, open up `source/MiniJavaLLVM` in your IDE, and in the terminal (in the minijava-setup directory) run 

```sh
vagrant ssh
```

This `ssh`s you into the running VM, dropping you into a `bash` prompt. If you'd rather just use the shell in the VirtualBox GUI, uncomment this line in the `Vagrantfile`:

```ruby
# vb.gui = true
```

In any event, once you've got a shell in the VM, run

```sh
cd /vagrant/
ls
```

Look familiar? This is the Ubuntu box's view onto the `minijava-setup` directory you were looking at before.

To compile MiniJavaLLVM:

```sh
cd source/MiniJavaLLVM/
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

Notifications, in this system, are `Diagnostic`s. The actual errors raised when problems are encountered are also `Diagnostic`s.

In the `notifications.diagnostics.thrownerrors` package, you find the errors thrown when the compiler encounters problems. Each of these classes is (should be?) unique to the site at which it's thrown -- that is to say, `DoWhileTestError` is only thrown in a `DoWhile.java`, exactly where that error is applicable.

These also all inherit from `CompilerDiagnosticBuilder`, which contains default implementations for `getText` and `getPos`. These are used by the compiler's diagnostic handler, which is ultimately what prints messages. See `AssignmentTypeError` for an example of overriding this method -- so far, all that's really been required has been indirection, but there may be more complex logic here for `CompilerDiagnosticBuilder`s that contain multiple diagnostics.

The `Diagnostic` types in the `notifications.diagnostics` package are leftovers from the previous implementation. I believe all of them can be expressed in terms of unsatisfied implications.

Unsatisfied implications are in the `notifications.implication` package. `UnsatisfiedImplicationDiagnostic` is the star of the show. Its constructor takes an `Antecedent` and a `Consequent`.

[vagrant]: https://www.vagrantup.com/
[vagrantfile]: https://github.com/mambocab/minijava-setup/blob/master/Vagrantfile
