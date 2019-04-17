using System;
using System.Linq;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;
using DevExpress.ExpressApp.DC;
using DevExpress.Persistent.Validation;
using DevExpress.Persistent.Base.General;
using DevExpress.Persistent.Base;
using System.Data.Entity.ModelConfiguration;
using DevExpress.ExpressApp;

namespace TreeNSI.Module.BusinessObjects
{
    [Table("view_TreeNSI_Addr_AddressesClassifierRU_Locality")]
    [DefaultClassOptions]
    public class vAddressesClassifierRU
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdAddrClassifierRU_Locality { get; protected set; }
        public string Name { get; protected set; }
        public string LocalityType { get; protected set; }
        public string Code { get; protected set; }
        public string Region0Name { get; protected set; }
        public string Region1Name { get; protected set; }
        public string Postcode { get; protected set; }
        public bool IsActive { get; protected set; }
        public string ARCPSCode { get; protected set; }
        public string Description { get; protected set; }
        public int Version { get; protected set; }
        public int Status { get; protected set; }
        public DateTime BeginDate { get; protected set; }
        public int IdProperty { get; protected set; }
    }
}
