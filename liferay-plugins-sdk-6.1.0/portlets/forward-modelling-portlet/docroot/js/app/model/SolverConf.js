Ext.define('CF.model.SolverConf', {
  extend: 'Ext.data.Model',
  fields: [{
    name: 'name',
    type: 'string'
  }, {
    name: 'desc',
    type: 'string'
  }, {
    name: 'value',
    type: 'auto'
  }, {
    name: 'req',
    type: 'string'
  }, {
    name: 'editable',
    type: 'boolean',
    defaultValue: true,
  }, {
    name: 'group',
    type: 'string'
  }, {
    name: 'type',
    type: 'string'
  }, {
    name: 'options',
    type: 'auto'
  }, {
    name: 'step',
    type: 'auto'
  }]
});