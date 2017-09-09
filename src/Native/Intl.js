var _user$project$Native_Intl = function() {
  function formatMoneyAmount(localeName, amount) {
    var options = {};
    var numberFormat = new Intl.NumberFormat(localeName, options);

    return numberFormat.format(amount);
  }

  return {
    formatMoneyAmount: F2(formatMoneyAmount)
  };
}();
