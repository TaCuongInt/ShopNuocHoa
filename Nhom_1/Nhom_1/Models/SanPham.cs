namespace Nhom_1.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("SanPham")]
    public partial class SanPham
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public SanPham()
        {
            Anhs = new HashSet<Anh>();
            ChiTietDHs = new HashSet<ChiTietDH>();
            GioHangs = new HashSet<GioHang>();
        }

        [Key]
        public int Ma_SP { get; set; }

        [StringLength(200)]
        public string Ten_SP { get; set; }

        public int Ma_DM { get; set; }

        [StringLength(50)]
        public string ThuongHieu_SP { get; set; }

        [StringLength(50)]
        public string MuiHuong_SP { get; set; }

        [StringLength(50)]
        public string MucDich_SP { get; set; }

        public int? SoLuong_SP { get; set; }

        [StringLength(30)]
        public string NongDo_SP { get; set; }

        public int? DungTich_SP { get; set; }

        public int? GiaBan_SP { get; set; }

        [StringLength(4000)]
        public string MoTa_SP { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Anh> Anhs { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ChiTietDH> ChiTietDHs { get; set; }

        public virtual DanhMucSP DanhMucSP { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GioHang> GioHangs { get; set; }
    }
}
