using Microsoft.AspNetCore.Mvc.RazorPages.Infrastructure;

namespace LakeStatsFront.Models
{
    public class GetWaterTemperatureResponse
    {
        public List<GetWaterTemperatureResult> Results { get; set; } = new List<GetWaterTemperatureResult>();
        public string CorrelationId { get; set; }
    }
}
