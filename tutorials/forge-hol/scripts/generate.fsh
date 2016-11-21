
#  #####################  #
#  Creates a new project  #
#  #####################  #

project-new --named petstore --top-level-package org.jboss.forge.hol.petstore --type war --final-name petstore --version 7.0 ;

#  ####################### #
#  Add JavaEE 7 dependency #
#  ####################### #
javaee-setup --java-ee-version 7;

#  ########################################### #
#  Setup the deployment descriptors to Java EE 7
#  ########################################### #
jpa-setup --persistence-unit-name applicationPetstorePU --jpa-version 2.1 ;
cdi-setup --cdi-version 1.1 ;
ejb-setup --ejb-version 3.2 ;
faces-setup --faces-version 2.2 ;
servlet-setup --servlet-version 3.1 ;
rest-setup --jaxrs-version 2.0 ;



#  ###################  #
#  Creates constraints  #
#  ###################  #

constraint-new-annotation --named Email ;
constraint-new-annotation --named Login ;
constraint-new-annotation --named NotEmpty ;
constraint-new-annotation --named Price ;



#  ########################  #
#  Creates the domain model  #
#  ########################  #

#  Country entity
#  ############
jpa-new-entity --named Country ;
jpa-new-field --named isoCode --length 2 --column-name iso_code --not-nullable ;
jpa-new-field --named name --length 80 --not-nullable ;
jpa-new-field --named printableName --length 80 --column-name printable_name --not-nullable ;
jpa-new-field --named iso3 --length 3 ;
jpa-new-field --named numcode --length 3 ;
# Constraints
constraint-add --on-property isoCode --constraint NotNull ;
constraint-add --on-property isoCode --constraint Size --min 2 --max 2 ;
constraint-add --on-property name --constraint NotNull ;
constraint-add --on-property name --constraint Size --min 2 --max 80 ;
constraint-add --on-property printableName --constraint NotNull ;
constraint-add --on-property printableName --constraint Size --min 2 --max 80 ;
constraint-add --on-property iso3 --constraint NotNull ;
constraint-add --on-property iso3 --constraint Size --min 3 --max 3 ;
constraint-add --on-property numcode --constraint NotNull ;
constraint-add --on-property numcode --constraint Size --min 3 --max 3 ;
# Cache
java-add-annotation --annotation javax.persistence.Cacheable ;


#  Address embeddable
#  ############
jpa-new-embeddable --named Address ;
jpa-new-field --named street1 --length 50 --not-nullable ;
jpa-new-field --named street2 ;
jpa-new-field --named city  --length 50 --not-nullable ;
jpa-new-field --named state ;
jpa-new-field --named zipcode --column-name zip_code --length 10 --not-nullable ;
# Relationships
jpa-new-field --named country --type org.jboss.forge.hol.petstore.model.Country --relationship-type Many-to-One ;
# Constraints
constraint-add --on-property street1 --constraint Size --min 5 --max 50 ;
constraint-add --on-property street1 --constraint NotNull ;
constraint-add --on-property city --constraint Size --min 2 --max 50 ;
constraint-add --on-property city --constraint NotNull ;
constraint-add --on-property zipcode --constraint Size --min 1 --max 10 ;
constraint-add --on-property zipcode --constraint NotNull ;


#  Customer entity
#  ############
jpa-new-entity --named Customer ;
jpa-new-field --named firstName --length 50 --column-name first_name --not-nullable ;
jpa-new-field --named lastName --length 50 --column-name last_name --not-nullable ;
jpa-new-field --named telephone ;
jpa-new-field --named email ;
jpa-new-field --named login --length 10 --not-nullable ;
jpa-new-field --named password --length 256 --not-nullable ;
jpa-new-field --named dateOfBirth --type java.util.Date --temporal-type DATE --column-name date_of_birth ;
jpa-new-field --named age --type java.lang.Integer --transient ;
# Address embeddable
jpa-new-field --named street1 --length 50 ;
jpa-new-field --named street2 ;
jpa-new-field --named city --length 50 ;
jpa-new-field --named state ;
jpa-new-field --named zipcode --column-name zip_code --length 10 ;
# Relationships
jpa-new-field --named country --type org.jboss.forge.hol.petstore.model.Country --relationship-type Many-to-One ;
# Constraints
constraint-add --on-property password --constraint NotNull ;
constraint-add --on-property password --constraint Size --min 1 --max 256 ;
constraint-add --on-property firstName --constraint NotNull ;
constraint-add --on-property firstName --constraint Size --min 2 --max 50 ;
constraint-add --on-property lastName --constraint NotNull ;
constraint-add --on-property lastName --constraint Size --min 2 --max 50 ;
constraint-add --on-property dateOfBirth --constraint Past ;


#  Category entity
#  ############
jpa-new-entity  --named Category ;
jpa-new-field --named name --length 30 --not-nullable ;
jpa-new-field --named description --length 3000 --not-nullable ;
# Constraints
constraint-add --on-property name --constraint NotNull ;
constraint-add --on-property name --constraint Size --min 1 --max 30 ;
constraint-add --on-property description --constraint NotNull ;
constraint-add --on-property description --constraint Size --max 3000 ;
# Cache
java-add-annotation --annotation javax.persistence.Cacheable ;


#  Product entity
#  ############
jpa-new-entity --named Product ;
jpa-new-field --named name --length 30 --not-nullable ;
jpa-new-field --named description --length 3000 --not-nullable ;
# Relationships
jpa-new-field --named category --type org.jboss.forge.hol.petstore.model.Category --relationship-type Many-to-One ;
# Constraints
constraint-add --on-property name --constraint NotNull ;
constraint-add --on-property name --constraint Size --min 1 --max 30 ;
constraint-add --on-property description --constraint NotNull ;
constraint-add --on-property description --constraint Size --max 3000 ;
# Cache
java-add-annotation --annotation javax.persistence.Cacheable ;


#  Item entity
#  ############
jpa-new-entity --named Item ;
jpa-new-field --named name --length 30 --not-nullable ;
jpa-new-field --named description --length 3000 --not-nullable ;
jpa-new-field --named imagePath --column-name image_path ;
jpa-new-field --named unitCost --type java.lang.Float --column-name unit_cost ;
# Relationships
jpa-new-field --named product --type org.jboss.forge.hol.petstore.model.Product --relationship-type Many-to-One ;
# Constraints
constraint-add --on-property name --constraint NotNull ;
constraint-add --on-property name --constraint Size --min 1 --max 30 ;
constraint-add --on-property description --constraint NotNull ;
constraint-add --on-property description --constraint Size --max 3000 ;
constraint-add --on-property unitCost --constraint NotNull ;
# Cache
java-add-annotation --annotation javax.persistence.Cacheable ;


#  CreditCardType enumeration
#  ############
java-new-enum --named CreditCardType --target-package ~.model ;
java-add-enum-const --named VISA ;
java-add-enum-const --named MASTER_CARD ;
java-add-enum-const --named AMERICAN_EXPRESS ;

java-new-class --named CreditCardConverter --target-package ~.model ;


# CreditCard embeddable
# ############
jpa-new-embeddable --named CreditCard ;
jpa-new-field --named creditCardNumber --column-name credit_card_number --length 30 --not-nullable ;
jpa-new-field --named creditCardType --type org.jboss.forge.hol.petstore.model.CreditCardType --column-name credit_card_type ;
jpa-new-field --named creditCardExpDate --column-name credit_card_expiry_date --length 5 --not-nullable ;
# Constraints
constraint-add --on-property creditCardNumber --constraint NotNull ;
constraint-add --on-property creditCardNumber --constraint Size --min 1 --max 30 ;
constraint-add --on-property creditCardType --constraint NotNull ;
constraint-add --on-property creditCardExpDate --constraint NotNull ;
constraint-add --on-property creditCardExpDate --constraint Size --min 1 --max 5 ;


#  OrderLine entity
#  ############
jpa-new-entity --named OrderLine --table-name order_line ;
jpa-new-field --named quantity --type java.lang.Integer --not-nullable ;
# Relationships
jpa-new-field --named item --type org.jboss.forge.hol.petstore.model.Item --relationship-type Many-to-One ;
# Constraints
constraint-add --on-property quantity --constraint Min --value 1 ;


#  PurchaseOrder entity
#  ############
jpa-new-entity --named PurchaseOrder --table-name purchase_order ;
jpa-new-field --named orderDate --type java.util.Date --temporal-type DATE --column-name order_date ;
jpa-new-field --named totalWithoutVat --type java.lang.Float ;
jpa-new-field --named vatRate --type java.lang.Float --column-name vat_rate ;
jpa-new-field --named vat --type java.lang.Float ;
jpa-new-field --named totalWithVat --type java.lang.Float ;
jpa-new-field --named discountRate --type java.lang.Float --column-name discount_rate ;
jpa-new-field --named discount --type java.lang.Float ;
jpa-new-field --named total --type java.lang.Float ;
# Address embeddable
jpa-new-field --named street1 --length 50 ;
jpa-new-field --named street2 ;
jpa-new-field --named city --length 50 ;
jpa-new-field --named state ;
jpa-new-field --named zipcode --column-name zip_code --length 10 ;
# Relationships
jpa-new-field --named country --type org.jboss.forge.hol.petstore.model.Country --relationship-type Many-to-One ;
# Credit card embeddable
jpa-new-field --named creditCardNumber --column-name credit_card_number ;
jpa-new-field --named creditCardType --type org.jboss.forge.hol.petstore.model.CreditCardType --column-name credit_card_type ;
jpa-new-field --named creditCardExpDate --column-name credit_card_expiry_date  ;
# Relationships
jpa-new-field --named customer --type org.jboss.forge.hol.petstore.model.Customer --relationship-type Many-to-One ;
jpa-new-field --named orderLines --type org.jboss.forge.hol.petstore.model.OrderLine --relationship-type One-to-Many ;
# Constraints
constraint-add --constraint NotNull --on-property street1 ;
constraint-add --constraint Size --min 5 --max 50 --on-property street1 ;
constraint-add --constraint NotNull --on-property city ;
constraint-add --constraint Size --min 5 --max 50 --on-property city ;
constraint-add --constraint NotNull --on-property zipcode ;
constraint-add --constraint Size --min 1 --max 10 --on-property zipcode ;
constraint-add --constraint NotNull --on-property creditCardNumber ;
constraint-add --constraint Size --min 1 --max 30 --on-property creditCardNumber ;
constraint-add --constraint NotNull --on-property creditCardType ;
constraint-add --constraint NotNull --on-property creditCardExpDate ;
constraint-add --constraint Size --min 5 --max 5 --on-property creditCardExpDate ;



#  #######################  #
#  Creates utility classes  #
#  #######################  #

java-new-exception --named ValidationException --target-package ~.exceptions ;
java-new-class --named LoginContextProducer --target-package ~.security ;
java-new-class --named SimpleCallbackHandler --target-package ~.security ;
java-new-class --named SimpleLoginModule --target-package ~.security ;

#  Config producer
#  ############
cdi-new-qualifier --named ConfigProperty --target-package ~.util ;
java-new-class --named ConfigPropertyProducer --target-package ~.util ;

#  DatabaseProducer
#  ############
java-new-class --named DatabaseProducer --target-package ~.util ;
java-new-field --named em --type javax.persistence.EntityManager --generate-getter=false --generate-setter=false --update-to-sring=false ;
java-add-annotation --annotation javax.enterprise.inject.Produces --on-property em ;
java-add-annotation --annotation javax.persistence.PersistenceContext --on-property em ;

#  Logging Interceptor
#  ############
cdi-new-interceptor-binding --named Loggable --target-package ~.util ;
cdi-new-interceptor --named LoggingInterceptor --interceptor-binding org.jboss.forge.hol.petstore.util.Loggable --target-package ~.util ;
java-new-field --named logger --type org.apache.logging.log4j.Logger --generate-getter=false --generate-setter=false --update-to-string=false ;

#  Logging Producer
#  ############
java-new-class --named LoggingProducer --target-package ~.util ;

#  Number producer
#  ############
cdi-new-qualifier --named Vat --target-package ~.util ;
cdi-new-qualifier --named Discount --target-package ~.util ;
java-new-class --named NumberProducer --target-package ~.util ;

java-new-field --named vatRate --type java.lang.Float --generate-getter=false --generate-setter=false --update-to-string=false ;
java-add-annotation --annotation javax.enterprise.inject.Produces --on-property vatRate ;
java-add-annotation --annotation org.jboss.forge.hol.petstore.util.Vat --on-property vatRate ;
java-add-annotation --annotation javax.inject.Named --on-property vatRate ;

java-new-field --named discountRate --type java.lang.Float --generate-getter=false --generate-setter=false --update-to-string=false ;
java-add-annotation --annotation javax.enterprise.inject.Produces --on-property discountRate ;
java-add-annotation --annotation org.jboss.forge.hol.petstore.util.Discount --on-property discountRate ;
java-add-annotation --annotation javax.inject.Named --on-property discountRate ;



#  #####################  #
#  Adding a Service Tier  #
#  #####################  #

java-new-class --named AbstractService --target-package ~.service ;
ejb-new-bean --named CountryService ;
ejb-new-bean --named CustomerService ;
ejb-new-bean --named CategoryService ;
ejb-new-bean --named ProductService ;
ejb-new-bean --named ItemService ;
ejb-new-bean --named PurchaseOrderService ;
ejb-new-bean --named OrderLineService ;
java-new-class --named InventoryService --target-package ~.service ;
java-new-class --named ShippingService --target-package ~.service ;
java-new-class --named StatisticService --target-package ~.service ;
java-new-interface --named ComputablePurchaseOrder --target-package ~.service ;
cdi-new-decorator --named PurchaseOrderDecorator --delegate org.jboss.forge.hol.petstore.service.ComputablePurchaseOrder --target-package ~.service ;



#  #############################  #
#  Generates JSF beans and pages  #
#  #############################  #

scaffold-generate --targets org.jboss.forge.hol.petstore.model.Country --provider "Faces" ;
scaffold-generate --targets org.jboss.forge.hol.petstore.model.Customer --provider "Faces" ;
scaffold-generate --targets org.jboss.forge.hol.petstore.model.Category --provider "Faces" ;
scaffold-generate --targets org.jboss.forge.hol.petstore.model.Product --provider "Faces" ;
scaffold-generate --targets org.jboss.forge.hol.petstore.model.Item --provider "Faces" ;
scaffold-generate --targets org.jboss.forge.hol.petstore.model.OrderLine --provider "Faces" ;
scaffold-generate --targets org.jboss.forge.hol.petstore.model.PurchaseOrder --provider "Faces" ;

#  AbstractBean
#  ############
faces-new-bean --named AbstractBean --target-package ~.view ;

#  Utility beans
#  ############
faces-new-bean --named DebugBean --target-package ~.view.util ;
faces-new-bean --named LocalBean --target-package ~.view.util ;

#  CredentialsBean and AccountBean
#  ############
faces-new-bean --named AccountBean --target-package ~.view.credentials ;
faces-new-bean --named CredentialsBean --target-package ~.view.credentials ;
cdi-new-interceptor-binding --named LoggedIn --target-package ~.view.credentials ;

#  ShoppingCartBean
#  ############
faces-new-bean --named ShoppingCartBean --target-package ~.view.shopping ;
# java-add-annotation --annotation javax.enterprise.context.ConversationScoped ;

java-new-class --named ShoppingCartItem --target-package ~.view.shopping ;
java-new-field --named item --type org.jboss.forge.hol.petstore.model.Item ;
java-new-field --named quantity --type java.lang.Integer ;
# Constraints
constraint-add --constraint NotNull --on-property item ;
constraint-add --constraint NotNull --on-property quantity ;
constraint-add --constraint Min --on-property quantity --value 1 ;



#  ############################  #
#  Creates view utility classes  #
#  ############################  #

#  FacesContext producer
#  ############
java-new-class --named FacesProducer --target-package ~.view.util ;
java-new-field --named facesContext --type javax.faces.context.FacesContext --generate-getter=false --generate-setter=false --update-to-string=false ;
java-add-annotation --annotation javax.enterprise.inject.Produces --on-property facesContext ;

#  Exception
#  ############
cdi-new-interceptor-binding --named CatchException --target-package ~.view.util ;
cdi-new-interceptor --named ExceptionInterceptor --interceptor-binding org.jboss.forge.hol.petstore.view.util.CatchException  --target-package ~.view.util ;
java-new-field --named logger --type org.apache.logging.log4j.Logger --generate-getter=false --generate-setter=false --update-to-string=false ;



#  ########################  #
#  Generates REST endpoints  #
#  ########################  #

rest-generate-endpoints-from-entities --targets org.jboss.forge.hol.petstore.model.Country --content-type application/xml application/json ;
rest-generate-endpoints-from-entities --targets org.jboss.forge.hol.petstore.model.Customer --content-type application/xml application/json ;
rest-generate-endpoints-from-entities --targets org.jboss.forge.hol.petstore.model.Category --content-type application/xml application/json ;
rest-generate-endpoints-from-entities --targets org.jboss.forge.hol.petstore.model.Product --content-type application/xml application/json ;
rest-generate-endpoints-from-entities --targets org.jboss.forge.hol.petstore.model.Item --content-type application/xml application/json ;

#  Adding Java EE and Web Jars dependencies
#  ############################
project-add-dependencies org.apache.logging.log4j:log4j-core:2.0.2 ;
project-add-dependencies org.webjars:bootstrap:2.3.2 ;
project-add-dependencies org.primefaces:primefaces:5.1 ;
