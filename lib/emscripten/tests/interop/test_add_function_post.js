var newFuncPtr = Runtime.addFunction(function(num) {
    Module.print('Hello ' + num + ' from JS!');
});
Module.callMain([newFuncPtr.toString()]);
