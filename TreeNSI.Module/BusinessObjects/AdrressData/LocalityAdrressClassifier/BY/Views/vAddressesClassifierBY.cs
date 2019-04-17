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
    [Table("view_TreeNSI_Addr_AddressesClassifierBY_Locality")]
    [DefaultClassOptions]
    public class vAddressesClassifierBY
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdAddrClassifierBY_Locality { get; protected set; }
        public DateTime BeginDate { get; protected set; }
        public string Name { get; protected set; }
        public string LocalityType { get; protected set; }
        public string Code { get; protected set; }
        public DateTime? EndDate { get; protected set; }
        public string LocalityTypeCode { get; protected set; }
        public string DistrictCode { get; protected set; }
        public string DistrictName { get; protected set; }
        public string RegionCode { get; protected set; }
        public string RegionName { get; protected set; }
        public int IdProperty { get; protected set; }
        public bool IsActive { get; protected set; }
        public string Description { get; protected set; }
    }
}
