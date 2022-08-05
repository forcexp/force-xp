@IsTest
public class NullArgumentBlockerTest {
	@IsTest
	static void itShouldPreventNullValue() {
		Object argument1 = 'some string';
		Object argument2 = null;

		Exception caughtException = null;
		try {
			new NullArgumentBlocker()
				.forArgument(argument1)
				.forArgument(argument2)
				.throwExceptionIfAnyHasIssues();
		}
		catch(Exception e) {
			caughtException = e;
		}

		System.assertNotEquals(null, caughtException, 'An exception should be caught.');
		System.assert(caughtException instanceof IllegalArgumentException, 'An exception of type IllegalArgumentException should be caught.');
		System.assertEquals('Argument on index 1 is null.', caughtException.getMessage(), 'ArgumentNullException message is different from expected.');
	}

	@IsTest
	static void itShouldPreventEmptyStrings() {
		Object argument1 = 'some string';
		Object argument2 = 1;
		Object argument3 = '';

		Exception caughtException = null;
		try {
			new NullArgumentBlocker()
				.forArgument(argument1)
				.forArgument(argument2)
				.forArgument(argument3)
				.throwExceptionIfAnyHasIssues();
		}
		catch(Exception e) {
			caughtException = e;
		}

		System.assertNotEquals(null, caughtException, 'An exception should be caught.');
		System.assert(caughtException instanceof IllegalArgumentException, 'An exception of type IllegalArgumentException should be caught.');
		System.assertEquals('Argument on index 2 is an empty String.', caughtException.getMessage(), 'ArgumentNullException message is different from expected.');
	}

	@IsTest
	static void itShouldAllowEmptyStrings() {
		Object argument1 = 'some string';
		Object argument2 = 1;
		Object argument3 = '';

		Exception caughtException = null;
		try {
			new NullArgumentBlocker()
				.allowEmptyStrings()
				.forArgument(argument1)
				.forArgument(argument2)
				.forArgument(argument3)
				.throwExceptionIfAnyHasIssues();
		}
		catch(Exception e) {
			caughtException = e;
		}

		System.assertEquals(null, caughtException, 'An exception should NOT be caught.');
	}

	@IsTest
	static void itShouldPreventWhitespaceStrings() {
		Object argument1 = 'some string';
		Object argument2 = 1;
		Object argument3 = Datetime.now();
		Object argument4 = '  ';

		Exception caughtException = null;
		try {
			new NullArgumentBlocker()
				.forArgument(argument1)
				.forArgument(argument2)
				.forArgument(argument3)
				.forArgument(argument4)
				.throwExceptionIfAnyHasIssues();
		}
		catch(Exception e) {
			caughtException = e;
		}

		System.assertNotEquals(null, caughtException, 'An exception should be caught.');
		System.assert(caughtException instanceof IllegalArgumentException, 'An exception of type IllegalArgumentException should be caught.');
		System.assertEquals('Argument on index 3 is a whitespace String.', caughtException.getMessage(), 'ArgumentNullException message is different from expected.');
	}

	@IsTest
	static void itShouldAllowWhitespaceStrings() {
		Object argument1 = 'some string';
		Object argument2 = 1;
		Object argument3 = Datetime.now();
		Object argument4 = '  ';

		Exception caughtException = null;
		try {
			new NullArgumentBlocker()
				.allowWhitespaceStrings()
				.forArgument(argument1)
				.forArgument(argument2)
				.forArgument(argument3)
				.forArgument(argument4)
				.throwExceptionIfAnyHasIssues();
		}
		catch(Exception e) {
			caughtException = e;
		}

		System.assertEquals(null, caughtException, 'An exception should NOT be caught.');
	}

	@IsTest
	static void itShouldPreventEmptyLists() {
		Object argument1 = new List<Integer>();

		Exception caughtException = null;
		try {
			new NullArgumentBlocker()
				.forArgument(argument1)
				.throwExceptionIfAnyHasIssues();
		}
		catch(Exception e) {
			caughtException = e;
		}

		System.assertNotEquals(null, caughtException, 'An exception should be caught.');
		System.assert(caughtException instanceof IllegalArgumentException, 'An exception of type IllegalArgumentException should be caught.');
		System.assertEquals('Argument on index 0 is an empty List.', caughtException.getMessage(), 'ArgumentNullException message is different from expected.');
	}

	@IsTest
	static void itShouldAllowEmptyLists() {
		Object argument1 = new List<Integer>();

		Exception caughtException = null;
		try {
			new NullArgumentBlocker()
				.allowEmptyLists()
				.forArgument(argument1)
				.throwExceptionIfAnyHasIssues();
		}
		catch(Exception e) {
			caughtException = e;
		}

		System.assertEquals(null, caughtException, 'An exception should NOT be caught.');
	}

	@IsTest
	static void itShouldPreventListContainingNull() {
		Object argument1 = new List<Integer>{1, null};

		Exception caughtException = null;
		try {
			new NullArgumentBlocker()
				.forArgument(argument1)
				.throwExceptionIfAnyHasIssues();
		}
		catch(Exception e) {
			caughtException = e;
		}

		System.assertNotEquals(null, caughtException, 'An exception should be caught.');
		System.assert(caughtException instanceof IllegalArgumentException, 'An exception of type IllegalArgumentException should be caught.');
		System.assertEquals('Argument on index 0 (a List) contains a null value on index 1.', caughtException.getMessage(), 'ArgumentNullException message is different from expected.');
	}

	@IsTest
	static void itShouldPreventListsContainingEmptyString() {
		Object argument1 = 1;
		Object argument2 = new List<String>{'alpha', 'bravo', ''};

		Exception caughtException = null;
		try {
			new NullArgumentBlocker()
				.forArgument(argument1)
				.forArgument(argument2)
				.throwExceptionIfAnyHasIssues();
		}
		catch(Exception e) {
			caughtException = e;
		}

		System.assertNotEquals(null, caughtException, 'An exception should be caught.');
		System.assert(caughtException instanceof IllegalArgumentException, 'An exception of type IllegalArgumentException should be caught.');
		System.assertEquals('Argument on index 1 (a List) contains an empty String value on index 2.', caughtException.getMessage(), 'ArgumentNullException message is different from expected.');
	}

	@IsTest
	static void itShouldAllowListsContainingEmptyString() {
		Object argument1 = 1;
		Object argument2 = new List<String>{'alpha', 'bravo', ''};

		Exception caughtException = null;
		try {
			new NullArgumentBlocker()
				.allowListsContainingEmptyString()
				.forArgument(argument1)
				.forArgument(argument2)
				.throwExceptionIfAnyHasIssues();
		}
		catch(Exception e) {
			caughtException = e;
		}

		System.assertEquals(null, caughtException, 'An exception should NOT be caught.');
	}

	@IsTest
	static void itShouldPreventListsContainingWhitespaceString() {
		Object argument1 = 1;
		Object argument2 = new List<String>{'alpha', 'bravo', '  '};

		Exception caughtException = null;
		try {
			new NullArgumentBlocker()
				.forArgument(argument1)
				.forArgument(argument2)
				.throwExceptionIfAnyHasIssues();
		}
		catch(Exception e) {
			caughtException = e;
		}

		System.assertNotEquals(null, caughtException, 'An exception should be caught.');
		System.assert(caughtException instanceof IllegalArgumentException, 'An exception of type IllegalArgumentException should be caught.');
		System.assertEquals('Argument on index 1 (a List) contains a whitespace String value on index 2.', caughtException.getMessage(), 'ArgumentNullException message is different from expected.');
	}

	@IsTest
	static void itShouldAllowListsContainingWhitespaceString() {
		Object argument1 = 1;
		Object argument2 = new List<String>{'alpha', 'bravo', '  '};

		Exception caughtException = null;
		try {
			new NullArgumentBlocker()
				.allowListsContainingWhitespaceString()
				.forArgument(argument1)
				.forArgument(argument2)
				.throwExceptionIfAnyHasIssues();
		}
		catch(Exception e) {
			caughtException = e;
		}

		System.assertEquals(null, caughtException, 'An exception should NOT be caught.');
	}


}
