/**
 * @description Collection is an abstract class to be used as base to all classes
 * aiming to manipulate groups of objects of the same type.
 * Collections cannot be created with empty lists. By definition, Collections must contains at least one object.
 */
public abstract class Collection {

	protected Collection(List<Object> objects) {
		new NullArgumentBlocker().forArgument(objects).throwExceptionIfAnyHasIssues();
		this.privateItems = new List<Object>(objects);
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

	public virtual Objects asObjects() {
		return new Objects(items);
	}

	protected List<Object> items {
		get {
			return itemsGetterResult();
		}
	}

	protected Set<Object> itemsAsSet {
		get {
			return itemsAsSetGetterResult();
		}
	}

	protected Object item {
		get {
			return itemGetterResult();
		}
	}

	protected virtual Boolean areManyGetterResult() {
		return privateItems.size() > 1;
	}

	protected virtual Boolean areNotManyGetterResult() {
		return !areMany;
	}

	protected virtual Boolean isJustOneGetterResult() {
		return privateItems.size() == 1;
	}

	protected virtual Boolean isNotJustOneGetterResult() {
		return !isJustOne;
	}

	protected virtual Integer sizeGetterResult() {
		return privateItems.size();
	}

	protected virtual List<Object> itemsGetterResult() {
		return new List<Object>(privateItems);
	}

	protected virtual Set<Object> itemsAsSetGetterResult() {
		return new Set<Object>(privateItems);
	}

	protected virtual Object itemGetterResult() {
		abortGetItemWhenCollectionHasManyItems();
		return privateItems[0];
	}

	List<Object> privateItems;

	void abortGetItemWhenCollectionHasManyItems() {
		if (areMany) {
			throw new InvalidOperationOnCollectionWithManyItemsException(
				'Can use <this>.item on a Collection with many items.'
			);
		}
	}

	class InvalidOperationOnCollectionWithManyItemsException extends InvalidOperationException { }

}
