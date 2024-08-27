namespace Shapes {
  export class Triangle {
    /* ... */
  }
  export class Square {
    /* ... */
  }

  export class Box<Type> {
    contents: Type;
    constructor(value: Type) {
      this.contents = value;
    }
  }
  export class MyClass {
    name = "MyClass";
    getName(this: MyClass) {
      return this.name;
    }
  }
  export function helloWorld() {
    console.log("Hello, world!");
  }

}
const b = new Shapes.Box("hello!");

  const c = new Shapes.MyClass();
  // OK
  c.getName();
  
  // Error, would crash
  const g = c.getName;
console.log(Shapes.helloWorld() );