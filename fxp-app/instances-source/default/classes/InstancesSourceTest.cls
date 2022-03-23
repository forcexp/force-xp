@IsTest
public class InstancesSourceTest {
	@IsTest
	static void itShouldFailOnGettingAnInstanceForNull() {
		InstancesSource di = InstancesSource.i;
		Exception caughtException = null;

		Test.startTest();
		try {
			di.instanceFor(null);
		} catch (Exception e) {
			caughtException = e;
		}
		Test.stopTest();

		System.assertNotEquals(
			null,
			caughtException,
			'An IllegalArgumentException exception should have been thrown.'
		);

		System.assert(
			caughtException instanceof IllegalArgumentException,
			'expectedException should not be an instance of IllegalArgumentException.'
		);
	}

	@IsTest
	static void itShouldGetAnInstanceUsingContractType() {
		InstancesSource di = InstancesSource.i;

		Test.startTest();
		DiMessageProvider messageProvider = (DiMessageProvider)di.instanceFor(DiMessageProvider.class);
		Test.stopTest();

		System.assertNotEquals(null, messageProvider, 'messageProvider should not be null.');
		System.assert(messageProvider instanceof DiMessageProvider.WithSharingImplementation, 'messageProvider should be an instance of DiMessageProvider.' + InstancesSource.DEFAULT_WITH_SHARING_CLASSNAME + ' class.');
	}

	@IsTest
	static void itShouldGetTheSameInstanceUsingContractType() {
		InstancesSource di = InstancesSource.i;
		DiMessageProvider firstMessageProvider = (DiMessageProvider)di.instanceFor(DiMessageProvider.class);

		Test.startTest();
		DiMessageProvider messageProvider = (DiMessageProvider)di.instanceFor(DiMessageProvider.class);
		Test.stopTest();

		System.assertNotEquals(null, messageProvider, 'messageProvider should not be null.');
		System.assertEquals(firstMessageProvider, messageProvider, 'messageProvider should be the same instance as firstMessageProvider.');
	}

	@IsTest
	static void itShouldFailOnGettingANewInstanceUsingNullAsContractType() {
		InstancesSource di = InstancesSource.i;
		Exception caughtException = null;

		Test.startTest();
		try {
			di.newInstanceFor(null);
		} catch (Exception e) {
			caughtException = e;
		}
		Test.stopTest();

		System.assertNotEquals(
			null,
			caughtException,
			'An IllegalArgumentException exception should have been thrown.'
		);

		System.assert(
			caughtException instanceof IllegalArgumentException,
			'expectedException should not be an instance of IllegalArgumentException.'
		);
	}

	@IsTest
	static void itShouldGetANewInstanceUsingContractType() {
		InstancesSource di = InstancesSource.i;
		DiMessageProvider messageProvider = (DiMessageProvider)di.instanceFor(DiMessageProvider.class);

		Test.startTest();
		DiMessageProvider firstMessageProvider = (DiMessageProvider)di.newInstanceFor(DiMessageProvider.class);
		Test.stopTest();

		System.assertNotEquals(null, firstMessageProvider, 'firstMessageProvider should not be null.');
		System.assertNotEquals(null, messageProvider, 'messageProvider should not be null.');
		System.assertNotEquals(firstMessageProvider, messageProvider, 'messageProvider should not be the same instance as firstMessageProvider.');
	}

	@IsTest
	static void itShouldFailOnSettingWithSharingInstanceTypeUsingNullAsContractType() {
		InstancesSource di = InstancesSource.i;
		Exception caughtException = null;

		Test.startTest();
		try {
			di.setWithSharingInstanceTypeFor(null, NoImplementationClass.class);
		} catch (Exception e) {
			caughtException = e;
		}
		Test.stopTest();

		System.assertNotEquals(
			null,
			caughtException,
			'An IllegalArgumentException exception should have been thrown.'
		);

		System.assert(
			caughtException instanceof IllegalArgumentException,
			'expectedException should not be an instance of IllegalArgumentException.'
		);
	}

	@IsTest
	static void itShouldFailOnSettingWithSharingInstanceTypeUsingNullAsWithSharingInstanceType() {
		InstancesSource di = InstancesSource.i;
		Exception caughtException = null;

		Test.startTest();
		try {
			di.setWithSharingInstanceTypeFor(NoImplementationClass.class, null);
		} catch (Exception e) {
			caughtException = e;
		}
		Test.stopTest();

		System.assertNotEquals(
			null,
			caughtException,
			'An IllegalArgumentException exception should have been thrown.'
		);

		System.assert(
			caughtException instanceof IllegalArgumentException,
			'expectedException should not be an instance of IllegalArgumentException.'
		);
	}

	@IsTest
	static void itShoulSetTheInstanceType() {
		InstancesSource di = InstancesSource.i;

		Test.startTest();
		di.setWithSharingInstanceTypeFor(DiMessageProvider.class, DiMessageProvider.SomeOtherImplementation.class);
		DiMessageProvider messageProvider = (DiMessageProvider)di.instanceFor(DiMessageProvider.class);
		Test.stopTest();

		System.assertNotEquals(null, messageProvider, 'messageProvider should not be null.');
		System.assert(messageProvider instanceOf DiMessageProvider.SomeOtherImplementation, 'messageProvider should be an instance of DiMessageProvider.SomeOtherImplementation class.');
	}

	@IsTest
	static void itShouldFailOnGettingAWithoutSharingInstanceForNull() {
		InstancesSource di = InstancesSource.i;
		Exception caughtException = null;

		Test.startTest();
		try {
			di.withoutSharingInstanceFor(null);
		} catch (Exception e) {
			caughtException = e;
		}
		Test.stopTest();

		System.assertNotEquals(
			null,
			caughtException,
			'An IllegalArgumentException exception should have been thrown.'
		);

		System.assert(
			caughtException instanceof IllegalArgumentException,
			'expectedException should not be an instance of IllegalArgumentException.'
		);
	}

	@IsTest
	static void itShouldGetAWithoutSharingInstanceUsingContractType() {
		InstancesSource di = InstancesSource.i;

		Test.startTest();
		DiMessageProvider messageProvider = (DiMessageProvider)di.withoutSharingInstanceFor(DiMessageProvider.class);
		Test.stopTest();

		System.assertNotEquals(null, messageProvider, 'messageProvider should not be null.');
		System.assert(
			messageProvider instanceof DiMessageProvider.WithoutSharingImplementation,
			'messageProvider should be an instance of DiMessageProvider.' + InstancesSource.DEFAULT_WITHOUT_SHARING_CLASSNAME + ' class.'
		);
	}

	@IsTest
	static void itShouldGetTheSameWithoutSharingInstanceUsingContractType() {
		InstancesSource di = InstancesSource.i;
		DiMessageProvider firstMessageProvider = (DiMessageProvider)di.withoutSharingInstanceFor(DiMessageProvider.class);

		Test.startTest();
		DiMessageProvider messageProvider = (DiMessageProvider)di.withoutSharingInstanceFor(DiMessageProvider.class);
		Test.stopTest();

		System.assertNotEquals(null, messageProvider, 'messageProvider should not be null.');
		System.assertEquals(firstMessageProvider, messageProvider, 'messageProvider should be the same instance as firstMessageProvider.');
	}

	@IsTest
	static void itShouldFailOnGettingANewWithoutSharingInstanceUsingNullAsContractType() {
		InstancesSource di = InstancesSource.i;
		Exception caughtException = null;

		Test.startTest();
		try {
			di.newWithoutSharingInstanceFor(null);
		} catch (Exception e) {
			caughtException = e;
		}
		Test.stopTest();

		System.assertNotEquals(
			null,
			caughtException,
			'An IllegalArgumentException exception should have been thrown.'
		);

		System.assert(
			caughtException instanceof IllegalArgumentException,
			'expectedException should not be an instance of IllegalArgumentException.'
		);
	}

	@IsTest
	static void itShouldGetANewWithoutSharingInstanceUsingContractType() {
		InstancesSource di = InstancesSource.i;
		DiMessageProvider messageProvider = (DiMessageProvider)di.withoutSharingInstanceFor(DiMessageProvider.class);

		Test.startTest();
		DiMessageProvider firstMessageProvider = (DiMessageProvider)di.newWithoutSharingInstanceFor(DiMessageProvider.class);
		Test.stopTest();

		System.assertNotEquals(null, firstMessageProvider, 'firstMessageProvider should not be null.');
		System.assertNotEquals(null, messageProvider, 'messageProvider should not be null.');
		System.assertNotEquals(firstMessageProvider, messageProvider, 'messageProvider should not be the same instance as firstMessageProvider.');
	}

	@IsTest
	static void itShouldFailOnSettingWithoutSharingInstanceTypeUsingNullAsContractType() {
		InstancesSource di = InstancesSource.i;
		Exception caughtException = null;

		Test.startTest();
		try {
			di.setWithoutSharingInstanceTypeFor(null, NoImplementationClass.class);
		} catch (Exception e) {
			caughtException = e;
		}
		Test.stopTest();

		System.assertNotEquals(
			null,
			caughtException,
			'An IllegalArgumentException exception should have been thrown.'
		);

		System.assert(
			caughtException instanceof IllegalArgumentException,
			'expectedException should not be an instance of IllegalArgumentException.'
		);
	}

	@IsTest
	static void itShouldFailOnSettingWithoutSharingInstanceTypeUsingNullAsWithSharingInstanceType() {
		InstancesSource di = InstancesSource.i;
		Exception caughtException = null;

		Test.startTest();
		try {
			di.setWithoutSharingInstanceTypeFor(NoImplementationClass.class, null);
		} catch (Exception e) {
			caughtException = e;
		}
		Test.stopTest();

		System.assertNotEquals(
			null,
			caughtException,
			'An IllegalArgumentException exception should have been thrown.'
		);

		System.assert(
			caughtException instanceof IllegalArgumentException,
			'expectedException should not be an instance of IllegalArgumentException.'
		);
	}

	@IsTest
	static void itShoulSetTheWithoutSharingInstanceType() {
		InstancesSource di = InstancesSource.i;

		Test.startTest();
		di.setWithoutSharingInstanceTypeFor(DiMessageProvider.class, DiMessageProvider.SomeOtherImplementation.class);
		DiMessageProvider messageProvider = (DiMessageProvider)di.withoutSharingInstanceFor(DiMessageProvider.class);
		Test.stopTest();

		System.assertNotEquals(null, messageProvider, 'messageProvider should not be null.');
		System.assert(messageProvider instanceOf DiMessageProvider.SomeOtherImplementation, 'messageProvider should be an instance of DiMessageProvider.SomeOtherImplementation class.');
	}

	@IsTest
	static void itShouldFailOnGettingAInheritedSharingInstanceForNull() {
		InstancesSource di = InstancesSource.i;
		Exception caughtException = null;

		Test.startTest();
		try {
			di.inheritedSharingInstanceFor(null);
		} catch (Exception e) {
			caughtException = e;
		}
		Test.stopTest();

		System.assertNotEquals(
			null,
			caughtException,
			'An IllegalArgumentException exception should have been thrown.'
		);

		System.assert(
			caughtException instanceof IllegalArgumentException,
			'expectedException should not be an instance of IllegalArgumentException.'
		);
	}

	@IsTest
	static void itShouldGetAInheritedSharingInstanceUsingContractType() {
		InstancesSource di = InstancesSource.i;

		Test.startTest();
		DiMessageProvider messageProvider = (DiMessageProvider)di.inheritedSharingInstanceFor(DiMessageProvider.class);
		Test.stopTest();

		System.assertNotEquals(null, messageProvider, 'messageProvider should not be null.');
		System.assert(
			messageProvider instanceof DiMessageProvider.InheritedSharingImplementation,
			'messageProvider should be an instance of DiMessageProvider.' + InstancesSource.DEFAULT_INHERITED_SHARING_CLASSNAME + ' class.'
		);
	}

	@IsTest
	static void itShouldGetTheSameInheritedSharingInstanceUsingContractType() {
		InstancesSource di = InstancesSource.i;
		DiMessageProvider firstMessageProvider = (DiMessageProvider)di.inheritedSharingInstanceFor(DiMessageProvider.class);

		Test.startTest();
		DiMessageProvider messageProvider = (DiMessageProvider)di.inheritedSharingInstanceFor(DiMessageProvider.class);
		Test.stopTest();

		System.assertNotEquals(null, messageProvider, 'messageProvider should not be null.');
		System.assertEquals(firstMessageProvider, messageProvider, 'messageProvider should be the same instance as firstMessageProvider.');
	}

	@IsTest
	static void itShouldFailOnGettingANewInheritedSharingInstanceUsingNullAsContractType() {
		InstancesSource di = InstancesSource.i;
		Exception caughtException = null;

		Test.startTest();
		try {
			di.newInheritedSharingInstanceFor(null);
		} catch (Exception e) {
			caughtException = e;
		}
		Test.stopTest();

		System.assertNotEquals(
			null,
			caughtException,
			'An IllegalArgumentException exception should have been thrown.'
		);

		System.assert(
			caughtException instanceof IllegalArgumentException,
			'expectedException should not be an instance of IllegalArgumentException.'
		);
	}

	@IsTest
	static void itShouldGetANewInheritedSharingInstanceUsingContractType() {
		InstancesSource di = InstancesSource.i;
		DiMessageProvider messageProvider = (DiMessageProvider)di.inheritedSharingInstanceFor(DiMessageProvider.class);

		Test.startTest();
		DiMessageProvider firstMessageProvider = (DiMessageProvider)di.newInheritedSharingInstanceFor(DiMessageProvider.class);
		Test.stopTest();

		System.assertNotEquals(null, firstMessageProvider, 'firstMessageProvider should not be null.');
		System.assertNotEquals(null, messageProvider, 'messageProvider should not be null.');
		System.assertNotEquals(firstMessageProvider, messageProvider, 'messageProvider should not be the same instance as firstMessageProvider.');
	}

	@IsTest
	static void itShouldFailOnSettingInheritedSharingInstanceTypeUsingNullAsContractType() {
		InstancesSource di = InstancesSource.i;
		Exception caughtException = null;

		Test.startTest();
		try {
			di.setInheritedSharingInstanceTypeFor(null, NoImplementationClass.class);
		} catch (Exception e) {
			caughtException = e;
		}
		Test.stopTest();

		System.assertNotEquals(
			null,
			caughtException,
			'An IllegalArgumentException exception should have been thrown.'
		);

		System.assert(
			caughtException instanceof IllegalArgumentException,
			'expectedException should not be an instance of IllegalArgumentException.'
		);
	}

	@IsTest
	static void itShouldFailOnSettingInheritedSharingInstanceTypeUsingNullAsWithSharingInstanceType() {
		InstancesSource di = InstancesSource.i;
		Exception caughtException = null;

		Test.startTest();
		try {
			di.setInheritedSharingInstanceTypeFor(NoImplementationClass.class, null);
		} catch (Exception e) {
			caughtException = e;
		}
		Test.stopTest();

		System.assertNotEquals(
			null,
			caughtException,
			'An IllegalArgumentException exception should have been thrown.'
		);

		System.assert(
			caughtException instanceof IllegalArgumentException,
			'expectedException should not be an instance of IllegalArgumentException.'
		);
	}

	@IsTest
	static void itShoulSetTheInheritedSharingInstanceType() {
		InstancesSource di = InstancesSource.i;

		Test.startTest();
		di.setInheritedSharingInstanceTypeFor(DiMessageProvider.class, DiMessageProvider.SomeOtherImplementation.class);
		DiMessageProvider messageProvider = (DiMessageProvider)di.inheritedSharingInstanceFor(DiMessageProvider.class);
		Test.stopTest();

		System.assertNotEquals(null, messageProvider, 'messageProvider should not be null.');
		System.assert(messageProvider instanceOf DiMessageProvider.SomeOtherImplementation, 'messageProvider should be an instance of DiMessageProvider.SomeOtherImplementation class.');
	}

	@IsTest
	static void itShoulFailOnGettingInstanceForContractWithSharingUsingContractTypeWithoutImplementationClass() {
		InstancesSource di = InstancesSource.i;
		Type expectedContractType = NoImplementationClass.class;
		String expectedDefaultInstanceTypeName = NoImplementationClass.class.getName() + '.' + InstancesSource.DEFAULT_WITH_SHARING_CLASSNAME;
		Exception caughtException = null;

		Test.startTest();
		try {
			NoImplementationClass instance = (NoImplementationClass)di.instanceFor(NoImplementationClass.class);
		}
		catch (Exception ex) {
			caughtException = ex;
		}
		Test.stopTest();

		System.assertNotEquals(null, caughtException, 'An exception should have been caught.');
		System.assert(caughtException instanceOf InstancesSource.DefaultInstanceTypeNotFoundException, 'caughtException should be an instance of InstancesSource.DefaultInstanceTypeNotFoundException class.');

		InstancesSource.DefaultInstanceTypeNotFoundException typedException = (InstancesSource.DefaultInstanceTypeNotFoundException)caughtException;

		System.assertEquals(expectedContractType, typedException.contractType, 'contractType should have the expected value.');
		System.assertEquals(expectedDefaultInstanceTypeName, typedException.defaultInstanceTypeName, 'defaultInstanceTypeName should have the expected value.');
	}

	@IsTest
	static void itShoulFailOnSettingWithSharingInstanceType() {
		InstancesSource di = InstancesSource.i;
		Type expectedContractType = DiMessageProvider.class;
		Type expectedInstanceType = DiMessageProvider.WithSharingImplementation.class;
		Type expectedNewInstanceType = DiMessageProvider.SomeOtherImplementation.class;
		Exception caughtException = null;
		di.instanceFor(DiMessageProvider.class);

		Test.startTest();
		try {
			di.setWithSharingInstanceTypeFor(DiMessageProvider.class, DiMessageProvider.SomeOtherImplementation.class);
		}
		catch (Exception ex) {
			caughtException = ex;
		}
		Test.stopTest();

		System.assertNotEquals(null, caughtException, 'An exception should have been caught.');
		System.assert(caughtException instanceOf InstancesSource.InstanceTypeAlreadyDefinedException, 'caughtException should be an instance of InstancesSource.InstanceTypeAlreadyDefinedException class.');

		InstancesSource.InstanceTypeAlreadyDefinedException typedException = (InstancesSource.InstanceTypeAlreadyDefinedException)caughtException;

		System.assertEquals(expectedContractType, typedException.contractType, 'contractType should have the expected value.');
		System.assertEquals(expectedInstanceType, typedException.instanceType, 'instanceType should have the expected value.');
		System.assertEquals(expectedNewInstanceType, typedException.newInstanceType, 'newInstanceType should have the expected value.');
	}

	class NoImplementationClass {

	}
}
