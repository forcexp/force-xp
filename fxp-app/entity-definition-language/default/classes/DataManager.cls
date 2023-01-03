public with sharing class DataManager {

	public static DataManager i {
		get {
			if (i == null) {
				i = new DataManager();
			}
			return i;
		}
		private set;
	}

	public void save() {

	}

	Sobject selectRecord(HasIdentity expression) {

	}



	public interface HasIdentity {
		Expression identity();
	}

	abstract class Expression
			implements HasIdentity {

		public Expression identity() {
			return this;
		}
	}

	abstract class TwoSidesExpression extends Expression {
		Object leftSide;
		Object rightSide;
	}

	class IsEqualToAnyOf extends TwoSidesExpression { }



	public abstract class Record {
		public Sobject sobject() {
			if (sobjectInstance != null) {
				return sobjectInstance;
			}
			if (this instanceof HasIdentity) {
				setSobject();
				return sobjectInstance;
			}
			throw new UnknownSobjectException();
		}

		protected StringField stringFieldUsing(SobjectField field) {
			RecordField result = fields.get(field);
			
			if (result == null) {
				result = new StringField(this, field);
				fields.put(field, result);
			}

			return (StringField)result;
		}

		Map<SobjectField, RecordField> fields = new Map<SobjectField, RecordField>();
		Sobject sobjectInstance;

		void setSobject() {
			sobjectInstance = 
		}

	}


	class StringField extends RecordField {
		public StringField(Record record, SobjectField field) {
			super(record, field);
		}

		public String value() {
			return asString();
		}

		public void setTo(String value) {
			if (!String.isNotBlank(value)) {
				setFieldValueTo(value);
			}
			throw new NotNonNullableValueException();
		}
	}

	abstract class RecordField {
		protected RecordField(Record record, SobjectField field) {
			this.record = record;
			this.field = field;
			previousValue = nullableValue();
		}

		public Boolean hasValue() {
			Object fieldValue = nullableValue();
			if (fieldValue == null) {
				return false;
			}
			if (fieldValue instanceof String) {
				return String.isNotBlank((String)fieldValue);
			}
			return true;
		}

		public Boolean doesNotHaveValue() {
			return !hasValue();
		}

		public Boolean hadValue() {
			if (previousValue == null) {
				return false;
			}
			if (previousValue instanceof String) {
				return String.isNotBlank((String)previousValue);
			}
			return true; 
		}

		public Boolean didNotHaveValue() {
			return !hadValue();
		}

		public Boolean hasChanged() {
			return previousValue != nullableValue();
		}

		public Boolean doesNotHaveChanged() {
			return previousValue == nullableValue();
		}

		public Boolean hasChangedToSomethingElse() {
			return hasChanged() && hasValue();
		}

		public Boolean wasRemoved() {
			return hasChanged() && doesNotHaveValue();
		}

		public Boolean wasSet() {
			return didNotHaveValue() && hasValue();
		}



		public void discardChange() {
			setFieldValueTo(previousValue);
		}

		public void remove() {
			setFieldValueTo(null);
		}


		public Boolean canBeAnInteger() {
			return canBeAnInteger(nullableValue());
		}

		protected Boolean canBeAnInteger(Object value) {
			Integer integerValue;
			try {
				integerValue = Integer.valueOf(value);
			} catch(TypeException e) {
				return false;
			}
			return integerValue != null;
		}

		public Boolean cannotBeAnInteger() {
			return !canBeAnInteger();
		}

		public Integer asInteger() {
			return Integer.valueOf(nonNullableValue());
		}

		public Boolean canBeAString() {
			return canBeAString(nullableValue());
		}

		protected Boolean canBeAString(Object value) {
			String stringValue;
			try {
				stringValue = String.valueOf(value);
			} catch(TypeException e) {
				return false;
			}
			return String.isNotBlank(stringValue);
		}

		public Boolean cannotBeAString() {
			return !canBeAString();
		}

		public String asString() {
			return String.valueOf(nonNullableValue());
		}


		protected void setFieldValueTo(Object value) {
			record.sobject().put(field, value);
		}


		Record record;
		SobjectField field;
		Object previousValue;

		Object nullableValue() {
			return record.sobject().get(field);
		}

		Object nonNullableValue() {
			if (hasValue()) {
				return nullableValue();
			}
			throw new AccessToNullException();
		}
	}

	public class UnknownSobjectException extends CustomException { }

	public class NotNonNullableValueException extends CustomException { }

	public class AccessToNullException extends CustomException { }

}
