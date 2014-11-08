#  ##############  #
#  Install Addons  #
#  ##############  #
#  If the following plugins are not installed
#  addon-install-from-git --url https://github.com/forge/addon-arquillian.git --coordinate org.arquillian.forge:arquillian-addon



#  #####################  #
#  Creates a new project  #
#  #####################  #

project-new --named petstore --topLevelPackage org.jboss.forge.hol.petstore --type war --finalName petstore --version 7.0 ;


#  Setup the deployment descriptors to Java EE 7
#  ############
jpa-setup --persistenceUnitName applicationPetstorePU --jpaVersion 2.1 ;
cdi-setup --cdiVersion 1.1 ;
ejb-setup --ejbVersion 3.2 ;
faces-setup --facesVersion 2.2 ;
servlet-setup --servletVersion 3.1 ;
rest-setup --jaxrsVersion 2.0 ;

#  Setup Arquillian
#  ############
arquillian-setup --arquillianVersion 1.1.5.Final --testFramework junit --testFrameworkVersion 4.11 --containerAdapter wildfly-remote --containerAdapterVersion 8.1.0.Final ;



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
jpa-new-field --named isoCode --length 2 --columnName iso_code --not-nullable ;
jpa-new-field --named name --length 80 --not-nullable ;
jpa-new-field --named printableName --length 80 --columnName printable_name --not-nullable ;
jpa-new-field --named iso3 --length 3 ;
jpa-new-field --named numcode --length 3 ;
# Constraints
constraint-add --onProperty isoCode --constraint NotNull ;
constraint-add --onProperty isoCode --constraint Size --min 2 --max 2 ;
constraint-add --onProperty name --constraint NotNull ;
constraint-add --onProperty name --constraint Size --min 2 --max 80 ;
constraint-add --onProperty printableName --constraint NotNull ;
constraint-add --onProperty printableName --constraint Size --min 2 --max 80 ;
constraint-add --onProperty iso3 --constraint NotNull ;
constraint-add --onProperty iso3 --constraint Size --min 3 --max 3 ;
constraint-add --onProperty numcode --constraint NotNull ;
constraint-add --onProperty numcode --constraint Size --min 3 --max 3 ;
# Cache
java-add-annotation --annotation javax.persistence.Cacheable ;


#  Address embeddable
#  ############
jpa-new-embeddable --named Address ;
jpa-new-field --named street1 --length 50 --not-nullable ;
jpa-new-field --named street2 ;
jpa-new-field --named city  --length 50 --not-nullable ;
jpa-new-field --named state ;
jpa-new-field --named zipcode --columnName zip_code --length 10 --not-nullable ;
# Relationships
jpa-new-field --named country --type org.jboss.forge.hol.petstore.model.Country --relationshipType Many-to-One
# Constraints
constraint-add --onProperty street1 --constraint Size --min 5 --max 50 ;
constraint-add --onProperty street1 --constraint NotNull ;
constraint-add --onProperty city --constraint Size --min 2 --max 50 ;
constraint-add --onProperty city --constraint NotNull ;
constraint-add --onProperty zipcode --constraint Size --min 1 --max 10 ;
constraint-add --onProperty zipcode --constraint NotNull ;


#  Customer entity
#  ############
jpa-new-entity --named Customer ;
jpa-new-field --named login --length 10 --not-nullable ;
jpa-new-field --named password --length 256 --not-nullable ;
jpa-new-field --named firstName --length 50 --columnName first_name --not-nullable ;
jpa-new-field --named lastName --length 50 --columnName last_name --not-nullable ;
jpa-new-field --named telephone ;
jpa-new-field --named email ;
jpa-new-field --named dateOfBirth --type java.util.Date --temporalType DATE --columnName date_of_birth ;
jpa-new-field --named age --type java.lang.Integer --transient ;
# Address embeddable
jpa-new-field --named street1 --length 50 ;
jpa-new-field --named street2 ;
jpa-new-field --named city --length 50 ;
jpa-new-field --named state ;
jpa-new-field --named zipcode --length 10 ;
# Constraints
constraint-add --onProperty password --constraint NotNull ;
constraint-add --onProperty password --constraint Size --min 1 --max 256 ;
constraint-add --onProperty firstName --constraint NotNull ;
constraint-add --onProperty firstName --constraint Size --min 2 --max 50 ;
constraint-add --onProperty lastName --constraint NotNull ;
constraint-add --onProperty lastName --constraint Size --min 2 --max 50 ;
constraint-add --onProperty dateOfBirth --constraint Past ;


#  Category entity
#  ############
jpa-new-entity  --named Category ;
jpa-new-field --named name --length 30 --not-nullable ;
jpa-new-field --named description --length 3000 --not-nullable ;
# Constraints
constraint-add --onProperty name --constraint NotNull ;
constraint-add --onProperty name --constraint Size --min 1 --max 30 ;
constraint-add --onProperty description --constraint NotNull ;
constraint-add --onProperty description --constraint Size --max 3000 ;
# Cache
java-add-annotation --annotation javax.persistence.Cacheable ;


#  Product entity
#  ############
jpa-new-entity --named Product ;
jpa-new-field --named name --length 30 --not-nullable ;
jpa-new-field --named description --length 3000 --not-nullable ;
# Relationships
jpa-new-field --named category --type org.jboss.forge.hol.petstore.model.Category --relationshipType Many-to-One ;
# Constraints
constraint-add --onProperty name --constraint NotNull ;
constraint-add --onProperty name --constraint Size --min 1 --max 30 ;
constraint-add --onProperty description --constraint NotNull ;
constraint-add --onProperty description --constraint Size --max 3000 ;
# Cache
java-add-annotation --annotation javax.persistence.Cacheable ;


#  Item entity
#  ############
jpa-new-entity --named Item ;
jpa-new-field --named name --length 30 --not-nullable ;
jpa-new-field --named description --length 3000 --not-nullable ;
jpa-new-field --named imagePath --columnName image_path ;
jpa-new-field --named unitCost --type java.lang.Float --columnName unit_cost ;
# Relationships
jpa-new-field --named product --type org.jboss.forge.hol.petstore.model.Product --relationshipType Many-to-One ;
# Constraints
constraint-add --onProperty name --constraint NotNull ;
constraint-add --onProperty name --constraint Size --min 1 --max 30 ;
constraint-add --onProperty description --constraint NotNull ;
constraint-add --onProperty description --constraint Size --max 3000 ;
constraint-add --onProperty unitCost --constraint NotNull ;
# Cache
java-add-annotation --annotation javax.persistence.Cacheable ;


#  CreditCardType enumeration
#  ############
java-new-enum --named CreditCardType --targetPackage org.jboss.forge.hol.petstore.model ;
java-new-enum-const VISA ;
java-new-enum-const MASTER_CARD ;
java-new-enum-const AMERICAN_EXPRESS ;

java-new-class --named CreditCardConverter --targetPackage org.jboss.forge.hol.petstore.model ;


# CreditCard embeddable
# ############
jpa-new-embeddable --named CreditCard ;
jpa-new-field --named creditCardNumber --columnName credit_card_number --length 30 --not-nullable ;
jpa-new-field --named creditCardType --type org.jboss.forge.hol.petstore.model.CreditCardType --columnName credit_card_type ;
jpa-new-field --named creditCardExpDate --columnName credit_card_expiry_date --length 5 --not-nullable ;
# Constraints
constraint-add --onProperty creditCardNumber --constraint NotNull ;
constraint-add --onProperty creditCardNumber --constraint Size --min 1 --max 30 ;
constraint-add --onProperty creditCardType --constraint NotNull ;
constraint-add --onProperty creditCardExpDate --constraint NotNull ;
constraint-add --onProperty creditCardExpDate --constraint Size --min 1 --max 5 ;


#  OrderLine entity
#  ############
jpa-new-entity --named OrderLine --tableName order_line ;
jpa-new-field --named quantity --type java.lang.Integer --not-nullable ;
# Relationships
jpa-new-field --named item --type org.jboss.forge.hol.petstore.model.Item --relationshipType Many-to-One ;
# Constraints
constraint-add --onProperty quantity --constraint Min --value 1 ;


#  PurchaseOrder entity
#  ############
jpa-new-entity --named PurchaseOrder --tableName purchase_order ;
jpa-new-field --named orderDate --type java.util.Date --temporalType DATE --columnName order_date ;
jpa-new-field --named totalWithoutVat --type java.lang.Float ;
jpa-new-field --named vatRate --type java.lang.Float --columnName vat_rate ;
jpa-new-field --named vat --type java.lang.Float ;
jpa-new-field --named totalWithVat --type java.lang.Float ;
jpa-new-field --named discountRate --type java.lang.Float --columnName discount_rate ;
jpa-new-field --named discount --type java.lang.Float ;
jpa-new-field --named total --type java.lang.Float ;
# Address embeddable
jpa-new-field --named street1 --length 50 ;
jpa-new-field --named street2 ;
jpa-new-field --named city --length 50 ;
jpa-new-field --named state ;
jpa-new-field --named zipcode --length 10 ;
# Credit card embeddable
jpa-new-field --named creditCardNumber --columnName credit_card_number ;
jpa-new-field --named creditCardType --type org.jboss.forge.hol.petstore.model.CreditCardType --columnName credit_card_type ;
jpa-new-field --named creditCardExpDate --columnName credit_card_expiry_date  ;
# Relationships
jpa-new-field --named customer --type org.jboss.forge.hol.petstore.model.Customer --relationshipType Many-to-One ;
jpa-new-field --named orderLines --type org.jboss.forge.hol.petstore.model.OrderLine --relationshipType One-to-Many ;
# Constraints
constraint-add --constraint NotNull --onProperty street1 ;
constraint-add --constraint Size --min 5 --max 50 --onProperty street1 ;
constraint-add --constraint NotNull --onProperty city ;
constraint-add --constraint Size --min 5 --max 50 --onProperty city ;
constraint-add --constraint NotNull --onProperty zipcode ;
constraint-add --constraint Size --min 1 --max 10 --onProperty zipcode ;
constraint-add --constraint NotNull --onProperty creditCardNumber ;
constraint-add --constraint Size --min 1 --max 30 --onProperty creditCardNumber ;
constraint-add --constraint NotNull --onProperty creditCardType ;
constraint-add --constraint NotNull --onProperty creditCardExpDate ;
constraint-add --constraint Size --min 5 --max 5 --onProperty creditCardExpDate ;



#  #######################  #
#  Creates utility classes  #
#  #######################  #

java-new-exception --named ValidationException --targetPackage org.jboss.forge.hol.petstore.exceptions ;
java-new-class --named LoginContextProducer --targetPackage org.jboss.forge.hol.petstore.security ;
java-new-class --named SimpleCallbackHandler --targetPackage org.jboss.forge.hol.petstore.security ;
java-new-class --named SimpleLoginModule --targetPackage org.jboss.forge.hol.petstore.security ;

#  Config producer
#  ############
cdi-new-qualifier --named ConfigProperty --targetPackage org.jboss.forge.hol.petstore.util ;
java-new-class --named ConfigPropertyProducer --targetPackage org.jboss.forge.hol.petstore.util ;

#  DatabaseProducer
#  ############
java-new-class --named DatabaseProducer --targetPackage org.jboss.forge.hol.petstore.util ;
java-new-field --named em --type javax.persistence.EntityManager --generateGetter=false --generateSetter=false --updateToString=false ;
java-add-annotation --annotation javax.enterprise.inject.Produces --onProperty em ;
java-add-annotation --annotation javax.persistence.PersistenceContext --onProperty em ;

#  Logging Interceptor
#  ############
cdi-new-interceptor-binding --named Loggable --targetPackage org.jboss.forge.hol.petstore.util ;
cdi-new-interceptor --named LoggingInterceptor --interceptorBinding org.jboss.forge.hol.petstore.util.Loggable --targetPackage org.jboss.forge.hol.petstore.util ;
java-new-field --named logger --type org.apache.logging.log4j.Logger --generateGetter=false --generateSetter=false --updateToString=false --updateToString=false ;

#  Logging Producer
#  ############
java-new-class --named LoggingProducer --targetPackage org.jboss.forge.hol.petstore.util ;

#  Number producer
#  ############
cdi-new-qualifier --named Vat --targetPackage org.jboss.forge.hol.petstore.util ;
cdi-new-qualifier --named Discount --targetPackage org.jboss.forge.hol.petstore.util ;
java-new-class --named NumberProducer --targetPackage org.jboss.forge.hol.petstore.util ;

java-new-field --named vatRate --type java.lang.Float --generateGetter=false --generateSetter=false --updateToString=false ;
java-add-annotation --annotation javax.enterprise.inject.Produces --onProperty vatRate ;
java-add-annotation --annotation org.jboss.forge.hol.petstore.util.Vat --onProperty vatRate ;
java-add-annotation --annotation javax.inject.Named --onProperty vatRate ;

java-new-field --named discountRate --type java.lang.Float --generateGetter=false --generateSetter=false --updateToString=false ;
java-add-annotation --annotation javax.enterprise.inject.Produces --onProperty discountRate ;
java-add-annotation --annotation org.jboss.forge.hol.petstore.util.Discount --onProperty discountRate ;
java-add-annotation --annotation javax.inject.Named --onProperty discountRate ;



#  #####################  #
#  Adding a Service Tier  #
#  #####################  #

java-new-class --named AbstractService --targetPackage org.jboss.forge.hol.petstore.service ;
ejb-new-bean --named CountryService ;
ejb-new-bean --named CustomerService ;
ejb-new-bean --named CategoryService ;
ejb-new-bean --named ProductService ;
ejb-new-bean --named ItemService ;
ejb-new-bean --named PurchaseOrderService ;
ejb-new-bean --named OrderLineService ;
java-new-class --named InventoryService --targetPackage org.jboss.forge.hol.petstore.service ;
java-new-class --named ShippingService --targetPackage org.jboss.forge.hol.petstore.service ;
java-new-class --named StatisticService --targetPackage org.jboss.forge.hol.petstore.service ;
java-new-interface --named ComputablePurchaseOrder --targetPackage org.jboss.forge.hol.petstore.service ;
cdi-new-decorator --named PurchaseOrderDecorator --delegate org.jboss.forge.hol.petstore.service.ComputablePurchaseOrder --targetPackage org.jboss.forge.hol.petstore.service ;



#  #############################  #
#  Generates JSF beans and pages  #
#  #############################  #

scaffold-generate --targets org.jboss.forge.hol.petstore.model.Country ;
scaffold-generate --targets org.jboss.forge.hol.petstore.model.Customer ;
scaffold-generate --targets org.jboss.forge.hol.petstore.model.Category ;
scaffold-generate --targets org.jboss.forge.hol.petstore.model.Product ;
scaffold-generate --targets org.jboss.forge.hol.petstore.model.Item ;
scaffold-generate --targets org.jboss.forge.hol.petstore.model.OrderLine ;
scaffold-generate --targets org.jboss.forge.hol.petstore.model.PurchaseOrder ;

#  AbstractBean
#  ############
faces-new-bean --named AbstractBean --targetPackage org.jboss.forge.hol.petstore.view ;

#  Utility beans
#  ############
faces-new-bean --named DebugBean --targetPackage org.jboss.forge.hol.petstore.view.util ;
faces-new-bean --named LocalBean --targetPackage org.jboss.forge.hol.petstore.view.util ;

#  CredentialsBean and AccountBean
#  ############
faces-new-bean --named AccountBean --targetPackage org.jboss.forge.hol.petstore.view.credentials ;
faces-new-bean --named CredentialsBean --targetPackage org.jboss.forge.hol.petstore.view.credentials ;
cdi-new-interceptor-binding --named LoggedIn --targetPackage org.jboss.forge.hol.petstore.view.credentials ;

#  ShoppingCartBean
#  ############
faces-new-bean --named ShoppingCartBean --targetPackage org.jboss.forge.hol.petstore.view.shopping ;
# java-add-annotation --annotation javax.enterprise.context.ConversationScoped ;

java-new-class --named ShoppingCartItem --targetPackage org.jboss.forge.hol.petstore.view.shopping ;
java-new-field --named item --type org.jboss.forge.hol.petstore.model.Item ;
java-new-field --named quantity --type java.lang.Integer ;
# Constraints
constraint-add --constraint NotNull --onProperty item ;
constraint-add --constraint NotNull --onProperty quantity ;
constraint-add --constraint Min --onProperty quantity --value 1 ;



#  ############################  #
#  Creates view utility classes  #
#  ############################  #

#  FacesContext producer
#  ############
java-new-class --named FacesProducer --targetPackage org.jboss.forge.hol.petstore.view.util ;
java-new-field --named facesContext --type javax.faces.context.FacesContext --generateGetter=false --generateSetter=false --updateToString=false ;
java-add-annotation --annotation javax.enterprise.inject.Produces --onProperty facesContext ;

#  Exception
#  ############
cdi-new-interceptor-binding --named CatchException --targetPackage org.jboss.forge.hol.petstore.view.util ;
cdi-new-interceptor --named ExceptionInterceptor --interceptorBinding org.jboss.forge.hol.petstore.view.util.CatchException  --targetPackage org.jboss.forge.hol.petstore.view.util ;
java-new-field --named logger --type org.apache.logging.log4j.Logger --generateGetter=false --generateSetter=false --updateToString=false ;



#  ########################  #
#  Generates REST endpoints  #
#  ########################  #

rest-generate-endpoints-from-entities --targets org.jboss.forge.hol.petstore.model.Country --contentType application/xml application/json ;
rest-generate-endpoints-from-entities --targets org.jboss.forge.hol.petstore.model.Customer --contentType application/xml application/json ;
rest-generate-endpoints-from-entities --targets org.jboss.forge.hol.petstore.model.Category --contentType application/xml application/json ;
rest-generate-endpoints-from-entities --targets org.jboss.forge.hol.petstore.model.Product --contentType application/xml application/json ;
rest-generate-endpoints-from-entities --targets org.jboss.forge.hol.petstore.model.Item --contentType application/xml application/json ;



#  ##################  #
#  Cleans the pom.xml  #
#  ##################  #

project-remove-dependencies org.hibernate.javax.persistence:hibernate-jpa-2.1-api:jar:: ;
project-remove-dependencies javax.enterprise:cdi-api:jar:: ;
project-remove-dependencies javax.ejb:javax.ejb-api:jar:: ;
project-remove-dependencies javax.faces:javax.faces-api:jar:: ;
project-remove-dependencies javax.servlet:javax.servlet-api:jar:: ;
project-remove-dependencies org.jboss.spec.javax.servlet:jboss-servlet-api_3.0_spec:jar:: ;
project-remove-dependencies javax.ws.rs:javax.ws.rs-api:jar:: ;
project-remove-dependencies javax.validation:validation-api:jar:: ;

project-remove-managed-dependencies org.hibernate.javax.persistence:hibernate-jpa-2.1-api:jar::1.0.0.Draft-16 ;
project-remove-managed-dependencies javax.enterprise:cdi-api:jar::1.1 ;
project-remove-managed-dependencies javax.ejb:javax.ejb-api:jar::3.2 ;
project-remove-managed-dependencies javax.faces:javax.faces-api:jar::2.2 ;
project-remove-managed-dependencies javax.servlet:javax.servlet-api:jar::3.1.0 ;
project-remove-managed-dependencies javax.ws.rs:javax.ws.rs-api:jar::2.0
project-remove-managed-dependencies org.jboss.spec:jboss-javaee-6.0:pom::3.0.2.Final ;

#  Adding Java EE and Web Jars dependencies
#  ############################
project-add-dependencies org.apache.logging.log4j:log4j-core:2.0.2 ;
project-add-dependencies org.webjars:bootstrap:2.3.2 ;
project-add-dependencies org.primefaces:primefaces:5.1 ;
project-add-dependencies org.jboss.spec:jboss-javaee-7.0:1.0.1.Final:provided:pom ;
