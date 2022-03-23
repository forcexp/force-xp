@IsTest
public class ArgumentsTest {
	@IsTest
	static void itShouldGetAnInstance() {
		System.assertNotEquals(null, Arguments.i, 'Arguments.i should not be null.');
	}

	@IsTest
	static void itShouldFailOnTestingIfArgumentHasValue() {
		Exception caughtException = null;

		Test.startTest();
		try {
			Arguments.i.proceedIfItHasValue(null, 'argumentNameWithNullValue');
		} catch (Exception e) {
			caughtException = e;
		}
		Test.stopTest();

		System.assertNotEquals(
			null,
			caughtException,
			'Arguments.i.proceedIfItHasValue should throw an exception.'
		);

		System.assert(
			caughtException instanceof IllegalArgumentException,
			'caughtException should be an instance of IllegalArgumentException.'
		);
	}

	@IsTest
	static void itShouldFailOnNotImplementedMethodCallUsingProceedIfItHasValue() {
		Exception caughtException = null;

		Test.startTest();
		try {
			new NotImplementedArguments().proceedIfItHasValue(null, 'argumentNameWithNullValue');
		} catch (Exception e) {
			caughtException = e;
		}
		Test.stopTest();

		System.assertNotEquals(
			null,
			caughtException,
			'Arguments.i.proceedIfItHasValue should throw an exception.'
		);

		System.assert(
			caughtException instanceof NotImplementedException,
			'caughtException should be an instance of NotImplementedException.'
		);
	}

	class NotImplementedArguments
		extends Arguments {

	}
}
