/**
 * @description: NullArgumentBlocker is desgined to help developers to
 * abort the execution of the code whenever a null value is passed as argument
 * to a public, protected or global method. For private methods, developers
 * should be able to avoid the injection of null values by designing the class
 * in a way where null values are not passed into these private methods.
 * NullArgumentBlocker process empty and whitespaced Strings as null values.
 * NullArgumentBlocker also finds null values inside lists.
 */
public with sharing class NullArgumentBlocker {
	public Validator forArgument(Object argumentValue) {
		validator.forArgument(argumentValue);
		return validator;
	}

	public NullArgumentBlocker allowEmptyStrings() {
		allowedIssues.add(EmptyStringArgumentIssue.class);
		return this;
	}

	public NullArgumentBlocker allowWhitespaceStrings() {
		allowedIssues.add(WhitespaceStringArgumentIssue.class);
		return this;
	}

	public NullArgumentBlocker allowEmptyLists() {
		allowedIssues.add(EmptyListArgumentIssue.class);
		return this;
	}

	public NullArgumentBlocker allowListsContainingEmptyString() {
		allowedIssues.add(ListContainingEmptyStringIssue.class);
		return this;
	}

	public NullArgumentBlocker allowListsContainingWhitespaceString() {
		allowedIssues.add(ListContainingWhitespaceStringIssue.class);
		return this;
	}

	Set<Type> allowedIssues = new Set<Type>();

	Validator validator {
		get {
			if (validator == null) {
				validator = new Validator(allowedIssues);
			}
			return validator;
		}
		set;
	}

	public class Validator {
		Validator(Set<Type> allowedIssues) {
			this.allowedIssues = allowedIssues;
		}

		public Validator forArgument(Object argumentValue) {
			argumentValues.add(argumentValue);
			return this;
		}

		public void throwExceptionIfAnyHasIssues() {

			for(Integer index = 0; index < argumentValues.size(); index++) {
				Object argumentValue = argumentValues[index];

				throwExceptionIfArgumentIssueIsNotNull(nullValueArgumentIssueFor(index, argumentValue));

				if (argumentValue instanceof String) {
					throwExceptionIfArgumentIssueIsNotNull(argumentIssueForStringValue(index, (String)argumentValue));
				}

				if (argumentValue instanceof List<Object>) {
					throwExceptionIfArgumentIssueIsNotNull(argumentIssueForListValue(index, (List<Object>)argumentValue));
				}
			}
		}

		Set<Type> allowedIssues;

		List<Object> argumentValues = new List<Object>();

		void throwExceptionIfArgumentIssueIsNotNull(ArgumentIssue argumentIssue) {
			if (ArgumentIssue != null) {
				throw new IllegalArgumentException(argumentIssue.getExceptionMessage());
			}
		}

		ArgumentIssue nullValueArgumentIssueFor(Integer index, Object argumentValue) {
			if (argumentValue == null) {
				return new NullArgumentIssue(index);
			}
			return null;
		}

		ArgumentIssue argumentIssueForStringValue(Integer index, String argumentValue) {
			if (!allowedIssues.contains(EmptyStringArgumentIssue.class) && argumentValue == '') {
				return new EmptyStringArgumentIssue(index);
			}

			if (!allowedIssues.contains(WhitespaceStringArgumentIssue.class) && argumentValue != '' && argumentValue.isWhitespace()) {
				return new WhitespaceStringArgumentIssue(index);
			}

			return null;
		}

		// FIXME: Address situations where there is infinite lists of Lists.
		ArgumentIssue argumentIssueForListValue(Integer argumentIndex, List<Object> argumentList) {
			if (!allowedIssues.contains(EmptyListArgumentIssue.class) && argumentList.isEmpty()) {
				return new EmptyListArgumentIssue(argumentIndex);
			}

			for (Integer valueIndex = 0; valueIndex < argumentList.size(); valueIndex++) {
				Object value = argumentList[valueIndex];

				if (value == null) {
					return new ListContainingNullIssue(argumentIndex, valueIndex);
				}

				if (!(value instanceof String)) {
					continue;
				}

				String valueAsString = (String)value;

				if (!allowedIssues.contains(ListContainingEmptyStringIssue.class) && valueAsString == '') {
					return new ListContainingEmptyStringIssue(argumentIndex, valueIndex);
				}

				if (!allowedIssues.contains(ListContainingWhitespaceStringIssue.class) && valueAsString != '' && valueAsString.isWhitespace()) {
					return new ListContainingWhitespaceStringIssue(argumentIndex, valueIndex);
				}
			}

			return null;
		}
	}

	abstract class ArgumentIssue {
		protected ArgumentIssue(Integer index) {
			this.index = index;
		}

		Integer index;

		abstract String getExceptionMessage();
	}

	class NullArgumentIssue extends ArgumentIssue {
		NullArgumentIssue(Integer index) {
			super(index);
		}

		override String getExceptionMessage() {
			return 'Argument on index ' + index + ' is null.';
		}
	}

	class EmptyStringArgumentIssue extends ArgumentIssue {
		EmptyStringArgumentIssue(Integer index) {
			super(index);
		}

		override String getExceptionMessage() {
			return 'Argument on index ' + index + ' is an empty String.';
		}
	}

	class WhitespaceStringArgumentIssue extends ArgumentIssue {
		WhitespaceStringArgumentIssue(Integer index) {
			super(index);
		}

		override String getExceptionMessage() {
			return 'Argument on index ' + index + ' is a whitespace String.';
		}
	}

	class EmptyListArgumentIssue extends ArgumentIssue {
		EmptyListArgumentIssue(Integer index) {
			super(index);
		}

		override String getExceptionMessage() {
			return 'Argument on index ' + index + ' is an empty List.';
		}
	}

	abstract class ListContainingValueWithIssue extends ArgumentIssue {
		protected ListContainingValueWithIssue(Integer index, Integer listValueIndex) {
			super(index);
			this.listValueIndex = listValueIndex;
		}

		Integer listValueIndex;
	}

	class ListContainingNullIssue extends ListContainingValueWithIssue {
		ListContainingNullIssue(Integer index, Integer listValueIndex) {
			super(index, listValueIndex);
		}

		override String getExceptionMessage() {
			return 'Argument on index ' + index + ' (a List) contains a null value on index ' + listValueIndex + '.';
		}
	}

	class ListContainingEmptyStringIssue extends ListContainingValueWithIssue {
		ListContainingEmptyStringIssue(Integer index, Integer listValueIndex) {
			super(index, listValueIndex);
		}

		override String getExceptionMessage() {
			return 'Argument on index ' + index + ' (a List) contains an empty String value on index ' + listValueIndex + '.';
		}
	}

	class ListContainingWhitespaceStringIssue extends ListContainingValueWithIssue {
		ListContainingWhitespaceStringIssue(Integer index, Integer listValueIndex) {
			super(index, listValueIndex);
		}

		override String getExceptionMessage() {
			return 'Argument on index ' + index + ' (a List) contains a whitespace String value on index ' + listValueIndex + '.';
		}
	}
}
