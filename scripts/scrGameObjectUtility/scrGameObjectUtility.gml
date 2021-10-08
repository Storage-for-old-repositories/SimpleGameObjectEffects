

#region functors

function functorFunc(_methOrFunc) {
	return (is_method(_methOrFunc) ? method_get_index(_methOrFunc) : _methOrFunc);
}

function functorMeth(_methOrFunc) {
	return method(undefined, _methOrFunc);
}

#endregion

#region Class-PriorityArray

function PriorityArray() constructor {
	
	#region __private
	
	self.__size  = 0;
	self.__array = [];
	
	#endregion
	
	static getSiz = function() {
		
		return self.__size;
	}
	
	static fndIndBeg = function(_priority) {
		
		for (var _i = 0; _i < self.__size; ++_i) {
			
			if (_priority <= self.__array[_i * 2]) return (_i * 2);
		}
		
		return -1;
	}
	
	static fndIndEnd = function(_priority) {
		
		for (var _i = self.__size - 1; _i >= 0; --_i) {
			
			if (_priority >= self.__array[_i * 2]) return (_i * 2);
		}
		
		return -1;
	}
	
	static addValBeg = function(_priority, _value) {
		
		var _ind = self.fndIndBeg(_priority);
		if (_ind == -1)
			array_push(self.__array, _priority, _value);
		else
			array_insert(self.__array, _ind, _priority, _value);
		
		++self.__size;
	}
	
	static addValEnd = function(_priority, _value) {
		
		var _ind = self.fndIndEnd(_priority);
		if (_ind == -1)
			array_insert(self.__array, 0, _priority, _value);
		else
			array_insert(self.__array, _ind + 2, _priority, _value);
		
		++self.__size;
	}
	
	static getVal = function(_index) {
		
		return self.__array[_index * 2 + 1];
	}
	
	static remVal = function(_index) {
		
		--self.__size;
		array_delete(self.__array, _index * 2, 2);
	}
	
	static forAllBeg = function(_f) {
		
		for (var _j, _i = 0; _i < self.__size; ++_i) {
			
			_j = _i * 2;
			if (_f(self.__array[_j])) {
				
				--_i;
				--self.__size;
				array_delete(self.__array, _j, 2);
			}
		}
	}
	
	static forAllEnd = function(_f) {
		
		for (var _j, _i = self.__size - 1; _i >= 0; --_i) {
			
			_j = _i * 2;
			if (_f(self.__array[_j])) {
				
				array_delete(self.__array, _j, 2);
			}
		}
		
		self.__size = array_length(self.__array) div 2;
	}
	
	static toArray = function() {
		
		var _array = array_create(self.__size);
		for (var _i = 0; _i < self.__size; ++_i) {
			
			_array[_i] = self.__array[_i * 2 + 1]; 
		}
		
		return _array;
	}
	
	static toString = function() {
		
		return string(self.toArray());
	}
	
}

#endregion

arr = new PriorityArray();
arr.addValEnd(50, "Hello");
arr.addValEnd(45, ">> ");
arr.addValEnd(55, "World");
arr.addValEnd(55, "!!!");

show_message(arr);