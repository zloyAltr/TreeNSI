using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;
using DevExpress.ExpressApp.DC;
using DevExpress.Persistent.Base;

namespace TreeNSI.Module.BusinessObjects
{
    [Table("view_TreeNSI_RailwayStantion")]
    public class vRailwayStantion
    {
        [Key]
        public Int32 IdRailwayStantion { get; protected set; }
        public string CountryAlfa2Code { get; protected set; }
        public string CountryName { get; protected set; }
        public string RailwayCountryCode { get; protected set; }
        public string Code { get; protected set; }
        public string BorderPointCode { get; protected set; }
        public string Name { get; protected set; }
        public bool? IsActive { get; protected set; }
        public Int32? IdRailwayCountry { get; protected set; }
        public Int32? IdCountry { get; protected set; }
    }
}
