# Gradle multi module project 
some tips to check highlighted

![image](https://github.com/sp496a/architectural-decission-records/assets/36936659/0bd2765d-5ce3-4415-9ffd-98319d43dbeb)

### Product composite 
this module is back end for frontend
createProduct , deleteProduct and getProduct
Only issue I see is same thing need to perform in Product Service 
But Composite service required as it has to get Data from each service and integrate
I will explain the thought process of reactive in our applcaition later.

Controller class we have to make sure that we use Immutable objects . We should always make attributes `private final productIntegration `
use lombok @requiredArgument(onConstruct_=@Autowired)

