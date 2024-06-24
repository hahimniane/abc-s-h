const tokenFunction=()=> {
  var originalOpen = XMLHttpRequest.prototype.open;
  XMLHttpRequest.prototype.open = function() {
    this.setRequestHeader('Authorization', 'Bearer 000000000000');
    originalOpen.apply(this, arguments);
  }};

export tokenFunction;