using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;
using DevExpress.ExpressApp.DC;
using DevExpress.Persistent.Base;

namespace TreeNSI.Module.BusinessObjects
{
    [Table("view_TreeNSI_RailwayCountry")]
    public class vRailwayCountry
    {
        [Key, ForeignKey("RailwayCountry")]
        public Int32 IdRailwayCountry { get; protected set; }
        public string Code { get; protected set; }
        public string CountryName { get; protected set; }
        public string CountryAlfa2Code { get; protected set; }
        public int? ContinentCode { get; protected set; }
        public string RICS { get; protected set; }
        public string RailwayShortName { get; protected set; }
        public string RailwayShortNameTranslit { get; protected set; }
        public string RailwayFullName { get; protected set; }
        public bool? IsActive { get; protected set; }
        public int? IdCountry { get; protected set; }
        public DateTime? BeginDate { get; protected set; }
        public Int32? IdProperty { get; protected set; }

        
        public virtual RailwayCountry RailwayCountry { get; set; }
    }
}
