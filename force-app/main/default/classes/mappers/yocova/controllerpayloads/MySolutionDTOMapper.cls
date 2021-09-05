public with sharing class MySolutionDTOMapper {

    public static MySolutionDTO toDTO(User user, List<Solution__c> solutions) {
        MySolutionDTO dto = new MySolutionDTO();
        dto.userName = user.Name;
        dto.solutionDTOs = SolutionDTOMapper.toDTOs(solutions);
        
        return dto;
    }
}