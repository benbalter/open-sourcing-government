/* Open all links in a new tab */
var links = document.getElementsByTagName('a');
for( var i = 0; i < links.length; i++ )
{
  links[i].target = '_blank';
}