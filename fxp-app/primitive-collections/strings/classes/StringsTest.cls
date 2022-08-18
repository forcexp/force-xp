@IsTest
public class StringsTest {
	@IsTest
	static void itShouldAbbreviate() {
		Strings collection = new Strings('Saulo', 'Hugo', 'Guilherme');
		List<String> expected = new List<String> { 'Saulo', 'Hugo', 'Gu...' };

		List<String> result = collection.abbreviate(5).asList();

		System.assertEquals(expected.size(), result.size(), 'result is not of the expected size.');
		for(Integer i = 0; i < expected.size(); i++) {
			System.assertEquals(expected[i], result[i], 'Abbreviation failed for item ' + i + '.');
		}
	}

	@IsTest
	static void itShouldCapitalize() {
		Strings collection = new Strings('paulo eduardo', 'paula licia');
		List<String> expected = new List<String> { 'Paulo eduardo', 'Paula licia' };

		List<String> result = collection.capitalize().asList();

		System.assertEquals(expected.size(), result.size(), 'result is not of the expected size.');
		for(Integer i = 0; i < expected.size(); i++) {
			System.assertEquals(expected[i], result[i], 'Capitalize failed for item ' + i + '.');
		}
	}
}
