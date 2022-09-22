@IsTest
public class StringArgumentsTest {
	@IsTest
	static void itShouldGetAnInstance() {
		System.assertNotEquals(null, StringArguments.i, 'StringArguments.i should not be null.');
	}

	@IsTest
	static void itShouldFailOnTestingIfStringArgumentHasValue() {
		Exception caughtException = null;

		Test.startTest();
		try {
			StringArguments.i.proceedIfItHasValue(' ', 'argumentNameWithBlankValue');
		} catch (Exception e) {
			caughtException = e;
		}
		Test.stopTest();

		System.assertNotEquals(
			null,
			caughtException,
			'StringArguments.i.proceedIfItHasValue should throw an exception.'
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
			new NotImplementedArguments().proceedIfItHasValue('salesforce', 'argumentNameWithValue');
		} catch (Exception e) {
			caughtException = e;
		}
		Test.stopTest();

		System.assertNotEquals(
			null,
			caughtException,
			'StringArguments.i.proceedIfItHasValue should throw an exception.'
		);

		System.assert(
			caughtException instanceof NotImplementedException,
			'caughtException should be an instance of NotImplementedException.'
		);
	}

	class NotImplementedArguments
		extends StringArguments {

	}
}
