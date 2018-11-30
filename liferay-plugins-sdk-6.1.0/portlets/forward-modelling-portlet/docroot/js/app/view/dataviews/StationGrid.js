/**
 * The grid in which summits are displayed
 * @extends Ext.grid.Panel
 */
Ext.define('CF.view.dataviews.StationGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.stationgrid',
    requires: [
        //'GeoExt.selection.FeatureModel',
        //'GeoExt.grid.column.Symbolizer',
        'Ext.grid.plugin.CellEditing',
        'Ext.grid.plugin.BufferedRenderer',
        'Ext.form.field.Number'
    ],
    id: 'stationgrid',
    border: false,
    selType: 'checkboxmodel',
    selModel: {
        checkOnly: true,
        listeners: {
            select: function(rowmodel, record, index) {
                 controller.onStationClick(record, true);
            },
            deselect: function(rowmodel, record, index) {
                controller.onStationClick(record, false);
            },
            selectionchange: function(t, s) {
                if (s.length > 1) Ext.getCmp('checkboxNSubmit').setDisabled(false);
                else Ext.getCmp('checkboxNSubmit').setDisabled(true);
                Ext.getCmp('stationSelColumn').setText(s.length + "/" + Ext.data.StoreManager.lookup('stationStore').data.length);
            }
        }
    },
    columns: [{
        header: '0/0', //it will be updated on selectionchange and when the grid reloads (in Map.js)
        id: 'stationSelColumn',
        dataIndex: 'symbolizer',
        menuDisabled: true,
        sortable: false,
        //xtype: 'gx_symbolizercolumn',
        width: 60
    }, {
        header: 'Station',
        dataIndex: 'station',
        flex: 3
    }, {
        header: 'Network',
        dataIndex: 'network',
        flex: 3
    }, {
        header: 'Elevation',
        dataIndex: 'elevation',
        flex: 3
    }, {
        header: 'Latitude',
        dataIndex: 'latitude',
        flex: 3
    }, {
        header: 'Longitude',
        dataIndex: 'longitude',
        flex: 3
    }, {
        xtype: 'actioncolumn',
        width: 40,
        tdCls: 'delete',
        items: [{
            icon: localResourcesPath + '/img/eye-3-256.png', // Use a URL in the icon config
            tooltip: 'Show/Hide',
            handler: function(grid, rowIndex, colIndex) {
                var rec = grid.getStore().getAt(rowIndex);
                controller.showStationInfo(rec.data);
            }
        }]
    }],
    flex: 1,
    initComponent: function() {
        this.store = Ext.data.StoreManager.lookup('stationStore');
        this.callParent(arguments);
    }
});