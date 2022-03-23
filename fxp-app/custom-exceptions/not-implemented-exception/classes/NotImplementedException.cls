public with sharing class NotImplementedException
		extends CustomException {
	public static NotImplementedException newInstance() {
		return new NotImplementedException('Block not implemented.');
	}
}
