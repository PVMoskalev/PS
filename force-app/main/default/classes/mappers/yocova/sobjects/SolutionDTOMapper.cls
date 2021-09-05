public class SolutionDTOMapper {

    /*
    FIELD_SET > FLS > Selector
    */

    public static SolutionDTO toDTO(Solution__c record) {
        SolutionDTO dto = new SolutionDTO();
        dto.id = record.Id;
        dto.name = record.Name;
        dto.type = record.Type__c;

        return dto;
    }

    public static List<SolutionDTO> toDTOs(List<Solution__c> records) {
        List<SolutionDTO> dtos = new List<SolutionDTO>();
        for (Solution__c record : records) {
            dtos.add(SolutionDTOMapper.toDTO(record));
        }

        return dtos;
    }

    public static Solution__c toSObject(SolutionDTO dto) {
        Solution__c record = new Solution__c();
        record.Id = dto.id;
        record.Name = dto.name;
        record.Type__c = dto.type;

        return record;
    }

    public static List<Solution__c> toSObjects(List<SolutionDTO> dtos) {
        List<Solution__c> records = new List<Solution__c>();
        for (SolutionDTO dto : dtos) {
            records.add(SolutionDTOMapper.toSObject(dto));
        }

        return records;
    }
}