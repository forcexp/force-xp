/**
 * @description Collection is an abstract class to be used as base to all classes
 * aiming to manipulate groups of objects of the same type.
 * Collections cannot be created with empty lists. By definition, Collections must contains at least one object.
 */
public abstract class Collection {

	protected Collection(List<Object> objects) {
		new NullArgumentBlocker().forArgument(objects).throwExceptionIfAnyHasIssues();
		this.collectionObjects = new List<Object>(objects);
	}

	public Boolean areMany {
		get {
			return areManyGetterResult();
		}
	}

	public Boolean areNotMany {
		get {
			return areNotManyGetterResult();
		}
	}

	public Boolean isJustOne {
		get {
			return isJustOneGetterResult();
		}
	}

	public Boolean isNotJustOne {
		get {
			return isNotJustOneGetterResult();
		}
	}

	public Integer size {
		get {
			return sizeGetterResult();
		}
	}

	protected virtual Boolean areManyGetterResult() {
		return collectionObjects.size() > 1;
	}

	protected virtual Boolean areNotManyGetterResult() {
		return !areMany;
	}

	protected virtual Boolean isJustOneGetterResult() {
		return collectionObjects.size() == 1;
	}

	protected virtual Boolean isNotJustOneGetterResult() {
		return !isJustOne;
	}

	protected virtual Integer sizeGetterResult() {
		return collectionObjects.size();
	}

	List<Object> collectionObjects;

	protected List<Object> objects {
		get {
			return new List<Object>(collectionObjects);
		}
	}
}
