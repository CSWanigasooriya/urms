"use strict"; 
class PyApp{
call_py_listener(email){
    console.log("Entered javascript function");
    eel.listener(email);
}
}
export default PyApp;