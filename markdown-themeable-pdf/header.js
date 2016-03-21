module.exports = function () {
  var dateFormat = function () {
    return (new Date(2016,2,22)).toLocaleDateString('it-IT', {
      weekday: 'long',
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
  };

  return {
    height: '1cm',
    contents: '<p style="text-align: right">'+dateFormat()+'</p>'
  };
};
